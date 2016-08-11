
require './lib/class_changes/string_edits'

class UI
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
    puts "Enter first year of Calendar:"
    start_year = gets.chomp.parse_string
    puts "Enter last year of Calendar:"
    end_year = gets.chomp.parse_string
    puts "Generating calendar..."
    dates = start_year, end_year
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

  def self.calculating
    puts "Calculating...\n"
  end

end
