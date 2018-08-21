# frozen_string_literal: true

require_relative "./application_record"

class Game < ApplicationRecord
  attr_reader :players,
              :scoreboard

  def initialize(names = [])
    @names = names
    @players = []
  end

  def begin
    generate_players
    setup_scoreboard

    10.times do |turn|
      players.each do |player|
        puts "#{player.name} : TURN #{turn + 1}"
        add_to_scoreboard(
          player: player,
          turn: take_turn(player),
          number: turn + 1
        )
        data = scoreboard.view[player.name]
        puts "SCORE #{data[:turns].last[:running_score]}"
        puts "\n\n----------------------------\n\n"
      end
    end

    puts "\n\n----- FINAL SCORES -----\n\n"

    players.each do |player|
      puts player.name
      data = scoreboard.view[player.name]
      puts data[:turns].last[:running_score]
    end
  end

  private

  attr_reader :names

  def number_of_players
    names.count
  end

  def generate_players
    names.each do |name|
      @players << Player.new(name)
    end
  end

  def setup_scoreboard
    @scoreboard = Scoreboard.new(@players)
    @scoreboard.setup
  end

  def take_turn(player)
    player.bowl!
  end

  def add_to_scoreboard(player:, turn:, number:)
    scoreboard.update(
      player_name: player.name,
      turn: turn,
      score: player.score,
      number: number
    )
  end
end
