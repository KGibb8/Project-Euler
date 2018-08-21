# frozen_string_literal: true

module Callbacks
  def self.included(base)
    base.send :include, ClassMethods
  end

  module ClassMethods
    [:before, :after].each do |prefix|
      define_method "#{prefix}_action" do |method, options, &block|
        callbacks = instance_variable_get("@#{prefix}_action") || []
        if block_given
          callbacks << &block
        else
          callbacks << proc { }
        end
      end
    end
  end
end
