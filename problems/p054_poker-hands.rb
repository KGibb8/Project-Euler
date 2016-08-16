=begin

In the card game poker, a hand consists of five cards and are ranked, from lowest
to highest, in the following way:

High Card: Highest value card.
One Pair: Two cards of the same value.
Two Pairs: Two different pairs.
Three of a Kind: Three cards of the same value.
Straight: All cards are consecutive values.
Flush: All cards of the same suit.
Full House: Three of a kind and a pair.
Four of a Kind: Four cards of the same value.
Straight Flush: All cards are consecutive values of same suit.
Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
The cards are valued in the order:
2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

If two players have the same ranked hands then the rank made up of the highest
value wins; for example, a pair of eights beats a pair of fives (see example 1
below). But if two ranks tie, for example, both players have a pair of queens,
then highest cards in each hand are compared (see example 4 below); if the highest
cards tie then the next highest cards are compared, and so on.

Consider the following five hands dealt to two players:

Hand	 	Player 1	 	  Player 2	 	       Winner
1	 	5H 5C 6S 7S KD    2C 3S 8S 8D TD  	Player 2
    Pair of Fives     Pair of Eights

2	 	5D 8C 9S JS AC 	  2C 5C 7D 8S QH  	Player 1
    Highest card Ace  Highest card Queen

3	 	2D 9C AS AH AC 	  3D 6D 7D TD QD  	Player 2
    Three Aces        Flush with Diamonds

4	 	4D 6S 9H QH QC 	  3D 6D 7H QD QS 	  Player 1
    Pair of Queens    Pair of Queens
    Highest card Nine Highest card Seven

5	 	2H 2D 4C 4D 4S 	  3C 3D 3S 9S 9D 	  Player 1
    Full House        Full House
    With Three Fours  with Three Threes

The file, poker.txt, contains one-thousand random hands dealt to two players.
Each line of the file contains ten cards (separated by a single space): the first
five are Player 1's cards and the last five are Player 2's cards. You can assume
that all hands are valid (no invalid characters or repeated cards), each player's
hand is in no specific order, and in each hand there is a clear winner.

How many hands does Player 1 win?

=end



def arrange_hand
  self.sort!
  if self.include? "T" then index = self.find_index("T"); self.insert(-1, self.delete_at(index)) end
  if self.include? "J" then index = self.find_index("J"); self.insert(-1, self.delete_at(index)) end
  if self.include? "Q" then index = self.find_index("Q"); self.insert(-1, self.delete_at(index)) end
  if self.include? "K" then index = self.find_index("K"); self.insert(-1, self.delete_at(index)) end
  if self.include? "A" then index = self.find_index("A"); self.insert(-1, self.delete_at(index)) end
  return self
end

def straight?
  return true if self == ["6", "7", "8", "9", "T"]
  return true if self == ["7", "8", "9", "T", "J"]
  return true if self == ["8", "9", "T," "J", "Q"]
  return true if self == ["9", "T", "J", "Q", "K"]
  return true if self == ["T", "J", "Q", "K", "A"]
  self.collect(&:to_i).sort.each_cons(2).all? { |x,y| y == x + 1 }
end

def find_hand(values, suits)

  hand = values.keys
  hand.arrange_hand
  high = values.select{|value, qty| value if qty == 1}.keys.sort.last

  case values.count

  when 5

    if suits.count != 1
      if hand.straight? then {:straight => hand} else {:high => hand.last} end
    else
      if hand.straight?
        if hand.include? "A" then {:royalflush => hand} else {:straightflush => hand} end
      else
        {:flush => hand}
      end
    end

  when 4

    pair = values.select{|value, qty| value if qty != 1}.keys
    # high = values.select{|value, qty| value if qty == 1}.keys.last
    {:pair => pair, :high => high}

  when 3

    three = values.select{|value, qty| value if qty == 3}.keys
    two_pair = values.select{|value, qty| value if qty == 2}.keys
    # high = values.select{|value, qty| value if qty == 1}.keys.last # ERROR -> :high=>["A", "3"]
    if three.empty? then {:two_pair => two_pair, :high => high} else {:three => three, :high => high} end

  when 2

    fullhouse = values.select{|value, qty| value if qty == 3 || qty == 2}.keys
    four = values.select{|value, qty| value if qty == 4}.keys
    # high = values.select{|value, qty| value if qty == 1}.keys
    if fullhouse.empty? then {:four => four, :high => high} else {:fullhouse => fullhouse} end

  end
end


def hand_type
  return 0 if self == :high
  return 1 if self == :pair
  return 2 if self == :two_pair
  return 3 if self == :three
  return 4 if self == :straight
  return 5 if self == :flush
  return 6 if self == :fullhouse
  return 7 if self == :four
  return 8 if self == :straightflush
  return 9 if self == :royalflush
end

def card_type
  if self.to_i != 0
     return self.to_i
  else
    return 10 if self == "T"
    return 11 if self == "J"
    return 12 if self == "Q"
    return 13 if self == "K"
    return 14 if self == "A"
  end
end


def determine_winner(p1, p2)
  # Gives precedence to relevant hands
  p1_hand = p1.keys.first.hand_type
  p2_hand = p2.keys.first.hand_type
  # Determines if the hand_type is the same
  result = p1_hand <=> p2_hand
  # Wins round if hand is better
  if result == 1
    @p1_score += 1 # OR YOU COULD RETURN SYMBOL :p1 or :p2 and expect that in a score method
    print "| p1: #{@p1_score} |"
    return {:winner => p1, :loser => p2}
  elsif result == -1
    @p2_score += 1
    print "| p2: #{@p2_score} |"
    return {:winner => p2, :loser => p1}
  else
  # if hand matches
    if p1.keys.first == :pair
      p1_pair = p1.values.first.first.card_type
      p2_pair = p2.values.first.first.card_type
      winner = p1_pair <=> p2_pair
      if winner == 1
        @p1_score += 1 # OR YOU COULD RETURN SYMBOL :p1 or :p2 and expect that in a score method
        print "| p1: #{@p1_score} |"
        return {:winner => p1, :loser => p2}
      elsif winner == -1
        @p2_score += 1
        print "| p2: #{@p2_score} |"
        return {:winner => p2, :loser => p1}
      elsif winner == 0
        # resolve to high card
        p1_high = p1.values.last.card_type
        p2_high = p2.values.last.card_type
        high_winner = p1_high <=> p2_high
        if high_winner == 1 then
          @p1_score += 1
          print "| p1: #{@p1_score} |"
          return {:winner => p1, :loser => p2}
        elsif high_winner == -1 then
          @p2_score += 1
          print "| p2: #{@p2_score} |"
          return {:winner => p2, :loser => p1}
        end
      end
    else
      n = 1
      until n > 5  # Resolves :flush, :straight, :fullhouse & :straightflush by comparing each card until someone wins
        p1_card = p1.values.first[-n].card_type
        p2_card = p2.values.first[-n].card_type
        winner = p1_card <=> p2_card
        if winner == 1
          @p1_score += 1
          print "| p1: #{@p1_score} |"
          return {:winner => p1, :loser => p2}
          break
        elsif winner == -1
          @p2_score += 1
          print "| p2: #{@p2_score} |"
          return {:winner => p2, :loser => p1}
          break
        else
          if n == 2 && winner == 0 && (p1.keys.first == :two_pair || p1.keys.first == :four) #  resolve to high card
            p1_high = p1.values.last.card_type
            p2_high = p2.values.last.card_type
            high_winner = p1_high <=> p2_high
            if high_winner == 1
              @p1_score += 1
              print "| p1: #{@p1_score} |"
              return {:winner => p1, :loser => p2}
              break
            elsif high_winner == -1
              @p2_score += 1
              print "| p2: #{@p2_score} |"
              return {:winner => p2, :loser => p1}
              break
            end
          elsif n == 3 && winner == 0 && (p1.keys.first == :three)
            p1_high = p1.values.last.card_type
            p2_high = p2.values.last.card_type
            high_winner = p1_high <=> p2_high
            if high_winner == 1
              @p1_score += 1
              print "| p1: #{@p1_score} |"
              return {:winner => p1, :loser => p2}
              break
            elsif high_winner == -1
              @p2_score += 1
              print "| p2: #{@p2_score} |"
              return {:winner => p2, :loser => p1}
              break
            end
          end
          n += 1
        end
      end
    end
  end
end

def log_results(filename)
  output = File.open(filename,"w")
  output << self.join("\n")
  output.close
end


#### GAME BEGINS HERE ####


require './objects/file-reader'

hands = FileReader.new('p054_poker.txt').poker

@p1_score = 0
@p2_score = 0
winning_hands = []
hands.collect do |cards|

  values = Hash.new(0)
  suits = Hash.new(0)
  cards.first.collect do |card|
    if card.size == 3
      values[card[0..1]] += 1
      suits[card[2]] += 1
    else
      values[card.scan(/./)[0]] += 1
      suits[card.scan(/./)[1]] += 1
    end
  end
  p1 = find_hand(values, suits)

  values = Hash.new(0)
  suits = Hash.new(0)
  cards.last.collect do |card|
    if card.size == 3
      values[card[0..1]] += 1
      suits[card[2]] += 1
    else
      values[card.scan(/./)[0]] += 1
      suits[card.scan(/./)[1]] += 1
    end
  end
  p2 = find_hand(values, suits)

  winning_hands << determine_winner(p1, p2)
end

winning_hands.log_results('p54_log.txt')

puts @p1_score

# Our find_hand method returns a hash with the key as the :handtype and the value as results
# It also returns a second item in hash when relevant, with key as :high, and value is the result
# Below is the set of rules we need to manifest in our method that decides the winner


# The method needs to select the hand.keys.first and compare the players results. Apply the above filter.
# If :handtype is the same, compare results.
# The hand.value.last.last sets the top end of all hands
# If hand.value.last.last is higher, said player wins the round. If it matches, compare the next card down
# With a flush, results will need to be compared card by card, whoever is lower first loses.
# With two pair, first compare top card, if higher, player wins, if not compare second, same again, then move to high to determine winner
# Hands that may need to look at high include :high, :pair, :two_pair, :three, :four
