# frozen_string_literal: true

module Validations
  ValidationError = Class.new(StandardError)

  def self.included(base)
    base.include(InstanceMethods)
    base.extend(ClassMethods)
  end

  class RecordErrors
    attr_reader :errors, :record

    def initialize(record, error = nil)
      @errors = [error].compact
      @record = record
    end

    def add(method, message)
      @errors << RecordError.new(method, message)
    end

    def blank?
      @errors.nil? || !@errors.any?
    end

    def any?
      @errors.any?
    end
  end

  class RecordError
    attr_reader :method, :message

    def initialize(method, message:)
      @method = method
      @message = message
    end
  end

  module InstanceMethods
    def errors
      self.class.run_validations(self)
    end

    def valid?
      self.errors.blank?
    end
  end

  module ClassMethods
    def validate(method, options = {}, &block)
      @validation_callbacks ||= []
      @validation_callbacks << Callbacks::Callback.new(
        to_call: block_given? ? block : Proc.new { |record| record.send(method) },
        method_name: method
      )
    end

    def run_validations(record)
      @before_validation_callbacks ||= []
      @before_validation_callbacks.each { |callback| callback.(record) }

      record_errors = RecordErrors.new(record)

      @validation_callbacks ||= []
      @validation_callbacks.each do |callback|
        begin
          callback.(record)
        rescue ValidationError => error
          record_errors.errors.add(callback.method_name, message: error)
        end
      end

      @after_validation_callbacks ||= []
      @after_validation_callbacks.each { |callback| callback.call(record) }

      record_errors
    end
  end
end
