# frozen_string_literal: true

require "yaml"
require "csv"

require './lib/callbacks'
require './lib/validations'

module Repository
  PersistenceError = Class.new(StandardError)


  def self.included(base)
    base.include(Callbacks)
    base.include(Validations)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module InstanceMethods
    def initialize(params = Hash.new)
      unless params.kind_of? Hash
        raise ArgumentError, "initialize with a hash"
      end

      params.each do |k, v|
        instance_variable_set("@#{k}", v)
        self.class.__send__(:attr_accessor, k.to_sym)
      end
    end

    def attributes
      self.instance_variables.inject({}) do |hash, variable|
        hash[variable.to_s.gsub(/@/,'').to_sym] = instance_variable_get(variable)
        hash
      end
    end

    def destroy
      before_destroy_callbacks = self.class.instance_variable_get("@before_destroy_callbacks") || []
      before_destroy_callbacks.each { |callback| callback.(self) }

      index = self.class.records.index(self)

      self.class.records.delete_at(index).tap do |destroyed|
        if destroyed
          after_destroy_callbacks = self.class.instance_variable_get("@after_destroy_callbacks") || []
          after_destroy_callbacks.each { |callback| callback.(self) }
          self.class.persist
        end
      end

      self
    end

    def update(params)
      before_update_callbacks = self.class.instance_variable_get("@before_update_callbacks") || []
      before_update_callbacks.each { |callback| callback.(self) }

      params.each do |k, v|
        self.send("#{k.to_sym}", v)
      end

      @attributes = params

      self.save

      after_update_callbacks = self.class.instance_variable_get("@after_update_callbacks") || []
      after_update_callbacks.each { |callback| callback.(self) }

      self
    end

    def save
      success = nil

      before_save_callbacks = self.class.instance_variable_get("@before_save_callbacks") || []
      before_save_callbacks.each { |callback| callback.(self) }

      unless success = self.persisted?
        self.class.records << self
        success = self.class.persist
      end

      after_save_callbacks = self.class.instance_variable_get("@after_save_callbacks") || []
      after_save_callbacks.each { |callback| callback.(self) } if success

      success
    end

    def persisted?
      !self.class.records.index(self).nil?
    end
  end

  module ClassMethods

    include Enumerable

    attr_accessor :persistence_strategy

    attr_writer :records

    def has_many(association, options = {})
      association_name = association.to_s
      singularized_association_name = association_name.end_with?("s") ? association_name[0..-2] : association_name
      association_class_name = singularized_association_name.to_s
                                                            .split("_")
                                                            .map(&:capitalize)
                                                            .join
      primary_association_name = self.name
                                     .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
                                     .gsub(/([a-z\d])([A-Z])/,'\1_\2')
                                     .downcase

      self.__send__(:define_method, association_name) do
        association_class = Object.const_get(association_class_name)
        association_class.where(primary_association_name.to_sym => self)
      end
    end

    def belongs_to(association_name, options = {})
      association_class_name = association_name.to_s
                                               .split("_")
                                               .map(&:capitalize)
                                               .join

      foreign_association_name = self.name
                                     .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
                                     .gsub(/([a-z\d])([A-Z])/,'\1_\2')
                                     .downcase

      self.__send__(:define_method, association_name) do
        association_class = Object.const_get(association_class_name)
        association_class.find_by(foreign_association_name => self)
      end
    end

    def records
      @records ||= []
    end

    def all
      records
    end

    def each
      if block_given?
        self.records.each { |record| yield(record) }
      else
        self.records.each
      end
    end

    def where(params)
      response = nil
      params.each do |record|
        if response.nil?
          response = records.select { |record| record.send(k) == v }
        else
          response = response.select { |record| record.send(k) == v }
        end
      end
      response
    end

    def find_by(params)
      where(params).first
    end

    def create(params)
      record = new(params)
      return record unless record.valid?
      @before_create_callbacks ||= []
      @before_create_callbacks.each { |callback| callback.(record) }
      record.save
      @after_create_callbacks ||= []
      @after_create_callbacks.each { |callback| callback.(record) }
      record
    end

    def update_all(params)
      records.each { record| record.update(params) }
    end

    def destroy_all
      records.clear
    end

    def load
      case self.persistence_strategy
      when :yaml
        if File.exist? "#{self.name}.yml"
          self.records = YAML.load_file(self.name)
        end
      when :csv
        csv_info = nil
        if File.exist? "#{self.name}.csv"
          File.open("#{self.name}.csv", "r") { |file| csv_info = file.read  }

          column_mappings = nil
          CSV.parse(csv_info) do |row|
            if column_mappings.nil?
              column_mappings = row
            else
              params = Hash.new
              column_mappings.each_with_index do |column, index|
                params[column.to_sym] = row[index]
              end
              self.create(params)
            end
          end
        end
      end
    end

    def persist
      success = nil
      case persistence_strategy ||= :yaml
      when :yaml
        storage = if File.exists?("#{self.name}.yml")
                    File.open("#{self.name}.yml", "w")
                  else
                    File.new("#{self.name}.yml", "w")
                  end

        success = storage.write(records.to_yaml)
      when :csv
        storage = if File.exists?("#{self.name}.csv")
                    File.open("#{self.name}.csv", "w")
                  else
                    File.new("#{self.name}.csv", "w")
                  end

        success = storage.write(records.to_csv)
      else
        raise PersistenceError, "No persistence strategy set"
      end

      success
    end
  end
end
