# You are given the following information, but you may prefer to do some research for yourself.

# 1 Jan 1900 was a Monday.
# Thirty days has September,
# April, June and November.
# All the rest have thirty-one,
# Saving February alone,
# Which has twenty-eight, rain or shine.
# And on leap years, twenty-nine.
# A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?


class String
def black;          "\e[30m#{self}\e[0m" end
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end
def brown;          "\e[33m#{self}\e[0m" end
def blue;           "\e[34m#{self}\e[0m" end
def magenta;        "\e[35m#{self}\e[0m" end
def cyan;           "\e[36m#{self}\e[0m" end
def gray;           "\e[37m#{self}\e[0m" end

def bg_black;       "\e[40m#{self}\e[0m" end
def bg_red;         "\e[41m#{self}\e[0m" end
def bg_green;       "\e[42m#{self}\e[0m" end
def bg_brown;       "\e[43m#{self}\e[0m" end
def bg_blue;        "\e[44m#{self}\e[0m" end
def bg_magenta;     "\e[45m#{self}\e[0m" end
def bg_cyan;        "\e[46m#{self}\e[0m" end
def bg_gray;        "\e[47m#{self}\e[0m" end

def bold;           "\e[1m#{self}\e[22m" end
def italic;         "\e[3m#{self}\e[23m" end
def underline;      "\e[4m#{self}\e[24m" end
def blink;          "\e[5m#{self}\e[25m" end
def reverse_color;  "\e[7m#{self}\e[27m" end
end


class User_Interface
  def self.introduction
    puts "Project Euler: Problem 19 - Counting Sundays\n".bold
    puts  "1 Jan 1900 was a Monday.".blue
    puts "Thirty days has September,".red
    puts "April, June and November.".green
    puts "All the rest have thirty-one,".brown
    puts "Saving February alone,".magenta
    puts "Which has twenty-eight, rain or shine.".cyan
    puts "And on leap years, twenty-nine.\n".gray
    puts "A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.\n"
    puts "How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?".bold
  end

  def self.gets_year_range
    puts "Enter start and end year of Calendar, separated by a comma:"
    dates = gets.chomp.strip.split(/\s*,\s*/).map {|x| x.to_i}
  end

  def self.day?
    puts "Which day of the week would you like to count?"
    gets.chomp.downcase.to_sym
  end

  def self.date?
    puts "The question requests: How many Sundays fell on the " + "first".bold + " of the month during the twentieth century"
    puts "Select another day/date to count:"
    gets.chomp.to_i
  end

end

class Year
  attr_reader :year, :months, :days_of_week
  def initialize(year)
    @year = year
    @leap = self.leap?
    @months = [self.jan, self.feb, self.mar, self.apr, self.may, self.jun, self.jul, self.aug, self.sep, self.oct, self.nov, self.dec]
  end

  def days?
    return 366 if @leap
    return 365
  end

  def leap?
    leap = false
    (@year % 4 == 0) ? leap = true : leap = false
    leap = false if (@year % 100 == 0)
    leap = true if (@year % 400 == 0)
    return leap
  end

  def jan; return 31 end
  def feb; return 28 if @leap == false; return 29 if @leap == true end
  def mar; return 31 end
  def apr; return 30 end
  def may; return 31 end
  def jun; return 30 end
  def jul; return 31 end
  def aug; return 31 end
  def sep; return 30 end
  def oct; return 31 end
  def nov; return 30 end
  def dec; return 31 end

end

class Pathway
  def initialize
    @day_count = 2
    @days_of_week = Hash.new(0)
  end

  def count_day(day)
    @days_of_week[day] += 1
  end

  def start
    User_Interface.introduction
    @range = User_Interface.gets_year_range
    start = Time.now
    puts "Calculating...\n"

    # Creates Array of Year objects
    years = []
    (@range[0]..@range[1]).each {|x| y = Year.new(x); years << y}

    # Day counter
    years.each do |year|
      year.months.each do |month|
        (1..month).each do |day|
          # year.count_day no longer a relevant method. Should call self.days_of_week
          self.count_day(:sun_first) if (day == 1 && @day_count == 7)
          self.count_day(:monday) if @day_count == 1
          self.count_day(:tuesday) if @day_count == 2
          self.count_day(:wednesday) if @day_count == 3
          self.count_day(:thursday) if @day_count == 4
          self.count_day(:friday) if @day_count == 5
          self.count_day(:saturday) if @day_count == 6
          self.count_day(:sunday) if @day_count == 7
          @day_count >= 7 ? @day_count = 1 : @day_count += 1
        end
      end
    end
    finish = Time.now
    puts "Calculation took #{(finish - start)} seconds."
    puts "\nNumber of Sundays that fell on the first of the month during the twentieth century..."
    puts "Answer = #{@days_of_week[:sun_first]}"
  end
end

calendar = Pathway.new
calendar.start


=begin

 - I'VE BUILT THIS ITERATOR BUT I MAY WELL BE ABLE TO CALCULATE THIS USING THE Time class

 - Find out which day is 1st Jan XXXX using current date as relative comparitor

    total_days = 0
    years.each do |year|
      UI.dot
      total days += year.days?
    end
    @day_count = total_days % 7

 - Add methods for User_Interface & in Pathway that allow for input to determine
   any year - calculate starting day (:monday..:sunday) and adjust @day_count accordingly
   to allow @range to work properly

=end
