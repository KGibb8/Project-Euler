
require './lib/procs/args'

class Year
  attr_reader :year, :months
  def initialize(year)
    @year = year
    @leap = self.leap
    @months = [self.jan, self.feb, self.mar, self.apr, self.may, self.jun, self.jul, self.aug, self.sep, self.oct, self.nov, self.dec]

=begin
    @months = {
      :january => self.jan,
      :february => self.feb,
      :march => self.mar,
      :april => self.apr,
      :may => self.may,
      :june => self.jun,
      :july => self.jul,
      :august => self.aug,
      :september => self.sep,
      :october => self.oct,
      :november => self.nov,
      :december => self.dec
      }
=end
  end

  def days; @months.inject(&sum) end

# def leap; false; (self.year % 4 == 0) ? true : false; false if (self.year % 100 == 0); true if (self.year % 400 == 0) end
# Why does this evaluate to nil? ERROR occurs after first two arguments, problem with third/fourth statement

  def leap
    leap = false
    (@year % 4 == 0) ? leap = true : leap = false
    leap = false if (@year % 100 == 0)
    leap = true if (@year % 400 == 0)
    return leap
  end

  def jan; 31 end
  def feb; @leap ? 29 : 28 end
  def mar; 31 end
  def apr; 30 end
  def may; 31 end
  def jun; 30 end
  def jul; 31 end
  def aug; 31 end
  def sep; 30 end
  def oct; 31 end
  def nov; 30 end
  def dec; 31 end

end
