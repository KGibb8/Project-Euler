# frozen_string_literal: true

require_relative "./application_record"

class Scoreboard < ApplicationRecord
  attr_reader :view,
              :players

  def initialize(players)
    @players = players
    @view = {}
  end

  def setup
    players.each do |player|
      view[player.name] = { turns: [] }
    end
  end

  def update(player_name:, turn:, score:, number:)
    view[player_name].tap do |player_data|
      player_data[:turns] << {
        turn: turn,
        number: number,
        running_score: score
      }
    end
  end
end
