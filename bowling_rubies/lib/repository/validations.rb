# frozen_string_literal: true

module Repository
  module Validations
    def self.included(base)
      base.include(InstanceMethods)
      base.extend(ClassMethods)
    end

    module InstanceMethods
      def errors
        self.class.instance_variable_get("@errors") ||
          Repository::Errors.new(self)
      end

      def valid?
        self.class.run_validations(self)
        self.errors.blank?
      end
    end

    module ClassMethods
      def validate(method, options = {}, &block)
        @validation_callbacks ||= []
        @validation_callbacks << Repository::Callbacks::Callback.new(
          to_call: block_given? ? block : Proc.new { |record| record.send(method) },
          method_name: method
        )
      end

      def run_validations(record)
        @before_validation_callbacks ||= []
        @before_validation_callbacks.each { |callback| callback.(record) }

        @errors = Repository::Errors.new(record)

        @validation_callbacks ||= []
        @validation_callbacks.each do |callback|
          callback.(record)
        end

        @errors.uniq!

        @after_validation_callbacks ||= []
        @after_validation_callbacks.each { |callback| callback.call(record) }
      end
    end
  end
end
