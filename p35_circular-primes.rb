
# The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.

# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

# How many circular primes are there below one million?

class UI
  def self.title
    puts "Project Euler: Problem 35 - Circular Primes\n".bold
  end

  def self.problem
    puts "The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.".blue
    puts "There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.\n".red
    puts "How many circular primes are there below 'n'?\n".cyan
  end

  def self.gets_n
    puts "Enter the upper search limit for finding circular primes..."
    gets.chomp.to_i
  end
end

class Fixnum
  def circular?
    circular = false
    count = 1
    integers = self.to_s.scan(/./)
    for i in 1..integers.length-1
      roulette = integers.drop(1) << integers.first
      string = roulette.inject("") {|num, item| num += item}
      number = string.to_i
      count += 1 if number.is_prime?
      integers = roulette
    end

    circular = true if count == integers.length

    return circular
  end

  def is_prime?
    is_prime = true

    if self == 1
      is_prime = false
    end

    if self == 2
      is_prime = true
    elsif self.even?
      is_prime = false
    end

    for i in 2..Math.sqrt(self)
      if self % i == 0
        is_prime = false
      end
    end

    return is_prime
  end
end

class Pathway
  def start
    UI.title
    UI.problem
    @limit = UI.gets_n
    puts "Calculating...\n"
    start = Time.now
    circular = []
    n = 1

    while n < @limit
      if n.is_prime?
        circular << n if n.circular?
      end
      n += 1
    end
    finish = Time.now
    puts "Calculation took #{finish - start} seconds.\n"
    puts "There are #{circular.length} circular primes below #{@limit}\n"
    puts "Would you like to see them? y/N"
    y_or_n = gets.chomp
    circular.each {|num| print "#{num} | "} if y_or_n.downcase == "y"
    puts "\nGAME OVER"
  end
end

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

problem = Pathway.new
problem.start
