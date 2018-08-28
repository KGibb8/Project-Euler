# frozen_string_literal: true

module Repository
  class Errors
    attr_reader :errors, :record

    def initialize(record, error = nil)
      @errors = [error].compact
      @record = record
    end

    def add(method, message)
      @errors << Error.new(method, message: message)
    end

    def blank?
      @errors.nil? || !@errors.any?
    end

    def any?
      @errors.any?
    end

    def uniq!
      @errors = @errors.sort_by {|a, b| a.method <=> b.method }
                       .with_index(1)
                       .reject do |error, i|
                         next_error = @errors[i]
                         return false if next_error.nil?
                         error.method !== next_error.method
                       end
    end
  end

  class Error
    attr_reader :method, :message

    def initialize(method, message:)
      @method = method
      @message = message
    end
  end
end
