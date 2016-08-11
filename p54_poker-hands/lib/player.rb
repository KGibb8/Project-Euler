class Player
  attr_reader :name, :hand, :cards
  def initialize(name)
    @name = name
  end

  def send_cards(cards)
    @cards = cards
  end

  def hand
    @hand = DetermineHand.new(@cards).best_hand
  end

end

# Poker generates players
# Poker generates Deck
# Poker creates hands and sends to players

# Player's gonna hold his hand
# Player will receive his hand from Poker class

# Player's gonna need to sort his cards
# Player will receive this ability from Cards class
# Player will be able to view the values(hash), suits(hash) and ranks(array) of the cards

# Player might want to determine his best hand
# Maybe player doesn't need to determine his best hand, player just shows his cards
# Poker class determines best hand

# In the future, player will want the ability to bet chips
