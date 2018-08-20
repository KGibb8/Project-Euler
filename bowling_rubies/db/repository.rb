# frozen_string_literal: true

require "yaml"
require "csv"

module Repository
  PersistenceError = Class.new(StandardError)

  def self.included(base)
    base.extend(ClassMethods)
  end

  def destroy
    self.class.all.delete(self)
    self.class.persist!
  end

  def save
    # return false if self.attributes.empty?
    self.class.store(self)
  end

  def valid?
    self.class.run_validations(self)
    self.errors.any?
  end

  def attributes
    {} # TODO
  end

  module ClassMethods

    attr_accessor :persistence_strategy

    [:save, :create, :validation].each do |action|
      [:before, :after].each do |prefix|
        define_method "#{prefix}_#{action}".to_sym do |method, options, &block|
          variable_name = "@#{prefix}_#{action}_callbacks"
          callbacks = instance_variable_get(variable_name)
          callbacks = instance_variable_set(variable_name, []) unless callbacks
          callbacks << method
          # callbacks << { method: method, options: options, block: &block }
        end
      end
    end

    def new(params)
      @before_initialize_callbacks ||= []
      params.merge(errors: [])
      entry = super(params)
      @after_initialize_callbacks ||= []
      entry
    end

    def find(id)
      entries.each do |entry|
        return entry if entry.id == id
      end

      nil
    end

    def where(params)
      entries.select do |entry|
        matched = params.selet {|k, v| entry.send(k) == v }}
        matched.count == params.keys.count
      end
    end

    def find_by(params)
      # where(params).first
      entries.each do |entry|
        matched = params.select { |k, v| entry.send(k) == v }
        return entry if matched.count == params.keys.count
      end

      nil
    end

    def create(params)
      entry = new(params)

      # return false unless entry.valid?

      @before_create_callbacks ||= []
      @before_create_callbacks.each do |method|
        entry.send(method)
      end

      entry.save

      @after_create_callbacks ||= []
      @after_create_callbacks.each do |method|
        entry.send(method)
      end

      entry
    end

    def all
      entries
    end

    def load(path = "./db")
      @path = path

      case @persistence_strategy ||= :yaml
      when :yaml
        @entries = YAML.load_file(path)
      when :csv
        @entries = CSV.parse(path)
      end

      @entries
    end

    def store(entry)
      @before_save_callbacks ||= []
      @before_save_callbacks.each do |method|
        entry.send(method)
      end

      entries << entry

      response = persist!

      @after_save_callbacks ||= []
      @after_save_callbacks.each do |method|
        entry.send(method)
      end

      response
    end

    def persist!
      path = @path || "./db"

      storage = if File.exists?(path)
                  File.open(path, "w")
                else
                  File.new(path, "w")
                end

      case @persistence_strategy ||= :yaml
      when :yaml
        response = storage.write(entries.to_yaml)
      when :csv
        response = storage.write(entries.to_csv)
      else
        raise PersistenceError, "No persistence strategy set"
      end

      response
    end

    def validate(method, options, &block)
      @validation_callbacks ||= []
      @validation_callbacks << method
    end

    def run_validations(entry)
      @before_validation_callbacks ||= []
      @before_validation_callbacks.each do |method|
        entry.send(method)
      end

      @validation_callbacks ||= []
      @validation_callbacks.each do |method|
        entry.send(method)
      rescue ValidationError => error
        # entry has no .errors accessor, will need one!
        entry.errors.push([method, error.message])
      end

      @after_validation_callbacks ||= []
      @after_validation_callbacks.each do |method|
        entry.send(method)
      end
    end

    private

    attr_writer :entries

    def entries
      @entries ||= []
    end
  end
