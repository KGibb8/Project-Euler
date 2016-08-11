class DetermineHand
  attr_reader :hand, :best_hand
  def initialize(hand)
    @hand = arrange_cards_by_value(hand)
    @best_hand = determine_best_hand
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

# Hand Types

  def high
    self.values.select{|value, qty| value if qty == 1}.keys.last
  end

  def pair
    self.values.select{|value, qty| value if qty == 2}.keys # EDIT: subbed == 2 for != 1
  end

  def two_pair
    self.values.select{|value, qty| value if qty == 3}.keys
  end

  def three
    self.values.select{|value, qty| value if qty == 3}.keys
  end

  def four
    self.values.select{|value, qty| value if qty == 4}.keys
  end

  def fullhouse
    self.values.select{|value, qty| value if qty == 3 || qty == 2}.keys
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
        if self.straight? then {:straight => self.ranks} else {:high => self.high} end
      else
        if self.straight?
          if self.ranks.include? "A" then {:royalflush => self.ranks} else {:straightflush => self.ranks} end
        else
          {:flush => self.ranks}
        end
      end

    when 4
      {:pair => self.pair, :high => self.high}
    when 3
      if self.three.empty?
        {:two_pair => self.two_pair, :high => self.high}
      else
        {:three => self.three, :high => self.high}
      end
    when 2
      if self.fullhouse.empty?
        {:four => self.four, :high => self.high}
      else
        {:fullhouse => self.fullhouse}
      end
    end
  end

end
