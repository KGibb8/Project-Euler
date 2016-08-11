class Cards
  attr_reader :cards
  def initialize(cards)
    @cards = arrange_cards_by_value(cards)
  end

  def arrange_cards_by_value(cards)
    ["T","J","Q","K","A"].collect do |letter|
      cards.each do |card|
        if card.include? letter then index = cards.find_index(card); cards.insert(-1, cards.delete_at(index)) end
      end
    end
    cards
  end

  def values
    values = Hash.new(0)
    @cards.collect {|card| values[card.scan(/./).first] += 1}
    values
  end

  def suits
    suits = Hash.new(0)
    @cards.collect {|card| suits[card.scan(/./).last] += 1}
    suits
  end

  def ranks
    self.values.keys
  end
end
