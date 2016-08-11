class Poker
  attr_reader :players, :deck
  def initialize
    @players = generate_players
    @deck = generate_deck
  end

  def generate_players
    UI.gets_players.collect {|name| Player.new(name)}
  end

  def generate_deck
    Deck.new.deck.flatten!
  end

  def shuffle_deck
    self.deck.shuffle!
  end

  def generate_hands
    hands = []
    self.players.each { hand = []; hands << hand }
    loop do
      hands.each do |hand|
        hand << self.deck.first
        self.deck.delete_at(0)
      end
      break if hands.flatten.size == hands.size * 5
    end

    # The following sends each generated hand to the respective player
    index = 0
    players.collect {|player| player.send_cards(hands[index]); index += 1}
  end

  def return_to_deck
    # Remove cards from players hands?
    self.deck.insert(-1, hands.flatten!).flatten!
  end

  # SEVERAL PROBLEMS WITH CONTROL FLOW
  # GAME INTRODUCTION SHOULD COME FIRST. Players should be created after introduction

  def start
    UI.introduction
    UI.begin_game
    self.shuffle_deck
    self.generate_hands
    hands = Hash.new
    self.players.collect {|player| hands[player.name] = player.hand}
    puts hands
  end

end
