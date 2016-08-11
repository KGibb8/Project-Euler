class Deck
  attr_reader :deck
  def initialize
    @deck = create_deck
  end

  def suits
    [self.clubs, self.spades, self.hearts, self.diamonds]
  end

  def values
    [ self.two, self.three, self.four, self.five, self.six,
      self.seven, self.eight, self.nine, self.ten, self.jack,
      self.queen, self.king, self.ace ]
  end

  def create_deck
    self.suits.collect { |suit| values.each {|value| value << suit}}
  end

  def clubs; "C" end
  def spades; "S" end
  def hearts; "H" end
  def diamonds; "D" end

  def two; "2" end
  def three; "3" end
  def four; "4" end
  def five; "5" end
  def six; "6" end
  def seven; "7" end
  def eight; "8" end
  def nine; "9" end
  def ten; "T" end
  def jack; "J" end
  def queen; "Q" end
  def king; "K" end
  def ace; "A" end

end
