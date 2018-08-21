# frozen_string_literal: true

require './lib/callbacks'

module Controllers
  class Application
    include Callbacks

    def render(collection, action:)
      klass = self.class.to_s.gsub(/^[A-Za-z]+::/, '')
      action_klass = action.to_s.capitalize # will only with for single word actions...
      namespaced_view_klass = ["Views", klass, action_klass].join("::")
      constant = Object.const_get(namespaced_view_klass)
      collection ? constant.new(collection).render : constant.new.render
    end

    def call(action)
      (@before_action_callbacks || []).each do |callback|
        options = callback[:options]
        if only = options.try(:[], :only)
          if only.kind_of? Array
            only.select { |method| method == action }
            .map {|method| callback[:callback].call(self) }

          elsif only.kind_of? Symbol && only == action
            callback[:callback].call(self)
          else
            raise StandardError, "options must be a symbol or array of symbols"
          end
        end
      end

      self.send(action)

      (@after_action_callbacks || []).each do |callback|
        options = callback[:options]
        if only = options.try(:[], :only)
          if only.kind_of? Array
            only.select { |method| method == action }
            .map {|method| callback[:callback].call(self) }

          elsif only.kind_of? Symbol && only == action
            callback[:callback].call(self)
          else
            raise StandardError, "options must be a symbol or array of symbols"
          end
        end
      end
    end
  end
end
