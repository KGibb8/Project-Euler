# frozen_string_literal: true

module Controllers
  class Pages < Controllers::Application
    before_action :puts_woof, only: :index

    def index
      @pages = nil
      render @pages, action: :index
    end

    private

    def puts_woof
      puts "WOOF"
    end
  end
end
