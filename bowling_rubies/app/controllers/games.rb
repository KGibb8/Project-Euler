# frozen_string_literal: true

require_relative './application'

module Controllers
  class Games < Controllers::Application
    before_action :find_game, only: [:show]

    def index
      @games = Game.all
      render @games, action: :index
    end

    def show
      return unless @game
      render @game, action: :show
    end

    private

    def find_game
      @game = Game.find_by(name: 'Winninnnggg')
    end
  end
end
