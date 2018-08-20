# frozen_string_literal: true

require './db/repository'
require './models/application_record'
require './models/player'
require './models/scoreboard'
require './models/turn'
require './models/game'

Config = Class.new

class Application
  attr_accessor :config

  def initialize(config = Config.new)
    @config = config
  end

  def start
    Game.new([
      "Kieran",
      "Pezz",
      "Amanda",
      "Dan Hayes"
    ]).begin
  end
end

App.new.start
