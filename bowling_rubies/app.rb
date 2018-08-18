# frozen_string_literal: true

class Scoreboard
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

class Game
  attr_reader :players,
              :scoreboard

  def initialize(names = [])
    @names = names
    @players = []
  end

  def start!
    generate_players!
    setup_scoreboard!

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

  def generate_players!
    names.each do |name|
      @players << Player.new(name)
    end
  end

  def setup_scoreboard!
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

class Player
  attr_reader :turns,
              :name

  def initialize(name)
    @name = name
    @turns = []
  end

  def score
    turns.sum(&:score)
  end

  def bowl!
    Turn.new.tap do |turn|
      turn.player = self
      @turns << turn
    end
  end
end

class Turn
  attr_accessor :player

  def initialize
    @bowl_1 = bowl
    @bowl_2 = @bowl_1 < 10 ? bowl : 0
    @score = nil
  end

  def score
    @score ||= bowls.sum
  end

  def strike?
    score.ten? &&
      bowl_1.ten? &&
      bowl_2.zero?
  end

  def spare?
    bowl_1 < 10 &&
      score.ten?
  end

  private

  attr_reader :bowls,
              :bowl_1,
              :bowl_2
  def bowl
    rand(10)
  end

  def bowls
    [bowl_1, bowl_2]
  end
end

Game.new([
  "Kieran",
  "Pezz",
  "Amanda",
  "Dan Hayes"
]).start!
