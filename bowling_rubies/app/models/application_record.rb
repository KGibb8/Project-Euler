# frozen_string_literal: true

class ApplicationRecord
  include Repository

  def initialize(params = Hash.new)
    unless params.kind_of? Hash
      raise ArgumentError, "initialize with a hash"
    end

    params.each do |k, v|
      instance_variable_set("@#{k}", v)
      self.class.__send__(:attr_accessor, k.to_sym)
    end
  end
end
