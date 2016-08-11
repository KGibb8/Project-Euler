
require './objects/procs'

class String
  def map_to_i
    self.scan(/./).map(&Proc.new {|i| i.to_i})
  end
=begin
  def score
    self.upcase.ord - 64
  end
=end
  def word_score(item)
    item.scan(/./).collect(&score).inject(&sum)
    # TypeError: wrong argument type Fixnum (expected Proc) ?!
  end
end
