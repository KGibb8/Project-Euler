# frozen_string_literal: true

require_relative './application'

module Controllers
  class Games < Controllers::Application
    before_action :find_game, only: [:show]

    def index
      @games = Game.all
      Views::Games::Index.new(@games)
    end

    def show
      # @game = Game.find()
    end

    private

    def find_game
      # @game = Game.find_by(???)
    end
  end
end
