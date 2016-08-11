
###### ALTERNATE VERSION --> LESS READABLE BUT REPEATS LESS

class Hand
  attr_reader :hand
  def initialize(hand)
    @hand = arrange_cards_by_value(hand)
  end

  def arrange_cards_by_value(hand)
    ["T","J","Q","K","A"].collect do |letter|
      hand.each do |card|
        if card.include? letter then index = hand.find_index(card); hand.insert(-1, hand.delete_at(index)) end
      end
    end
    hand
  end

  def values
    values = Hash.new(0)
    @hand.collect {|card| values[card.scan(/./).first] += 1}
    return values
  end

  def suits
    suits = Hash.new(0)
    @hand.collect {|card| suits[card.scan(/./).last] += 1}
    return suits
  end

  def ranks
    self.values.keys
  end

  def hand_type(n)
    type = self.values.select{|value, qty| value if qty == n}.keys
    if n == 1 then type.last else type end
  end

  def straight?
    high_straights = [
      ["6", "7", "8", "9", "T"],
      ["7", "8", "9", "T", "J"],
      ["8", "9", "T," "J", "Q"],
      ["9", "T", "J", "Q", "K"],
      ["T", "J", "Q", "K", "A"]
    ]

    high_straights.collect do |option|
      return true if self.ranks == option
    end

    self.ranks.collect(&:to_i).sort.each_cons(2).all? { |x,y| y == x + 1 }
  end

  def determine_best_hand
    case self.values.count

    when 5
      if suits.count != 1
        if self.straight? then {:straight => self.ranks} else {:high => self.hand_type(1)} end
      else
        if self.straight?
          if self.ranks.include? "A" then {:royalflush => self.royal} else {:straightflush => self.straightflush} end
        else
          {:flush => self.flush}
        end
      end

    when 4
      {:pair => self.hand_type(2), :high => self.hand_type(1)}
    when 3
      if self.three.empty?
        {:two_pair => self.hand_type(3), :high => self.hand_type(1)}
      else
        {:three => self.hand_type(3), :high => self.hand_type(1)}
      end
    when 2
      if self.fullhouse.empty?
        {:four => self.hand_type(4), :high => self.hand_type(1)}
      else
        {:fullhouse => self.hand_type(2) || self.hand_type(3)}
      end
    end
  end
end
