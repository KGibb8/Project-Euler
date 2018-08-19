# frozen_string_literal: true

require './db/repository'
require './models/application_record'
require './models/player'
require './models/scoreboard'
require './models/turn'
require './models/game'

Game.new([
  "Kieran",
  "Pezz",
  "Amanda",
  "Dan Hayes"
]).start!
