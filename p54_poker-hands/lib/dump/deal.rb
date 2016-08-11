class Deal
  def initialize(deck)

  end


end

players = [Player.new("Kieran"), Player.new("Rory"), Player.new("Nigel"), Player.new("Jakki")]

# Create and shuffle deck
game = Deck.new.deck
game.flatten!
game.shuffle!
game.shuffle!
game.shuffle!

# Deal cards
hands = []
players.each { hand = []; hands << hand }

loop do
  hands.each do |hand|
    hand << game.first
    game.delete_at(0)
  end
  break if hands.flatten.size == hands.size * 5
end

# Return cards to deck
game.insert(-1, hands.flatten!).flatten!





# Important things to note about Deal --> is deal a class, or is it an aspect of Game/Poker class?

# We want it to return any number of 5 card hands - we need to limit the number of players relative to a single deck
# Deal needs to know how many players there are in the game
# If we have more than that constant, we need to add in a second deck
# Cards are dealt from the top of the deck.
# First of all when the Deal is created, the Deck is shuffled. Randomly mix up the Deck array.
# Second, from the top of the pack, which we will call Deck[0], deal a card to each player in turn, until each player has 5 cards
# As we do so, each card dealt to player is removed from the Deck.
# At the end of each round the cards are returned at index[-1] in the sets of 5 from the players in turn
# This allows for the ability to card count
