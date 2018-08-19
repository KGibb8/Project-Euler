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

  def attributes
    {} # TODO
  end

  module ClassMethods

    attr_accessor :persistence_strategy

    [:save, :create].each do |action|
      [:before, :after].each do |prefix|
        define_method "#{prefix}_#{action}".to_sym do |method|
          variable_name = "@#{prefix}_#{action}_callbacks"
          callbacks = instance_variable_get(variable_name)
          callbacks = instance_variable_set(variable_name, []) unless callbacks
          callbacks << method
        end
      end
    end

    entry_accessors = [:first, :second, :third, :fourth, :fifth, :sixth]
    entry_accessors.each_with_index do |method, i|
      define_method method do
        entries[i]
      end
    end

    def new(*args)
      @before_initialize_callbacks ||= []
      entry = super(*args)
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
      entries.inject([]) do |collection, entry|
        matched = params.select { |k, v| entry.send(k) == v }
        binding.pry
        collection << entry if matched.count == params.keys.count
        collection
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

    private

    attr_writer :entries

    def entries
      @entries ||= []
    end
  end
