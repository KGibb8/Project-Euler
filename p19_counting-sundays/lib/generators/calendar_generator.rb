
require './lib/procs/args'

class Calendar
  attr_reader :years
  def initialize(range)
    @years = build_calendar(range)
  end

  def year_generator(date)
    Year.new(date)
  end

  def build_calendar(range)
    (range[0]..range[1]).collect {|x| self.year_generator(x)}
  end
end
