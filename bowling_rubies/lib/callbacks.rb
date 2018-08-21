# frozen_string_literal: true

module Callbacks
  def self.included(base)
    [:before, :after].each do |prefix|
      instance_variable_set("@#{prefix}_action", [])
    end

    base.extend(ClassMethods)
  end

  module ClassMethods
    [:before, :after].each do |prefix|
      define_method "#{prefix}_action" do |method, options, &block|
        callbacks = instance_variable_get("@#{prefix}_action")
        callbacks = instance_variable_set("@#{prefix}_action", []) unless callbacks
        callback = block_given? ? block : Proc.new {|record| entry.send(method) }
        callbacks << { callback: callback, options: options }
      end
    end
  end
end
