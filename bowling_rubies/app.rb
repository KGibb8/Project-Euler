# frozen_string_literal: true

require './environment/development'
require './config'
require './db/repository'

Dir["./app/models/*.rb", "./app/controllers/*.rb"].each { |file| require file }

class Application < Shoes
  include Config

  configure do |config|
    config.full_screen = true
  end

  url "/", :home_screen # would be nice if you could pass a lambda: -> { Controllers::Home.new.index }
  url "/settings", :settings_view
  url "/players", :players_view
  url "/player/:id", :player_view
  url "/games", :games_view
  url "/games/:id", :game_view

  def home_screen
    button "Settings" do
      visit "/settings"
    end
  end

  def settings_view
  end

  def games_view
    Controllers::Games.new(params).index
  end

  def game_view
    Controllers::Games.new(params).show
  end

  def players_view

  end

  def player_view

  end
end

Shoes.app(Application.config)
