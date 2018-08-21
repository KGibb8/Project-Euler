# frozen_string_literal: true

require_relative '../application'

module Views
  module Pages
    class Index < Views::Application
      def render
        button "Settings" do
          visit "/settings"
        end
      end
    end
  end
end
