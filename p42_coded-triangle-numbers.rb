
# The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); so
# the first ten triangle numbers are:

# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

# By converting each letter in a word to a number corresponding to its alphabetical
# position and adding these values we form a word value. For example, the word value
# for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number then we
# shall call the word a triangle word.

# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file
# containing nearly two-thousand common English words, how many are triangle words?

require './file-reader'
require './colours'
require './objects/string'

class Fixnum
  def triangular?
    num_to_check = (8 * self) + 1
    Math.sqrt(num_to_check) % 1 == 0 ? true : false
  end
end
=begin
class String
  def score
    self.ord - 64
  end
end
=end
class UI
  def self.question
    puts "Project Euler: Problem 42 - Coded Triangle Numbers\n".bold
    puts "The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); so the first ten triangle numbers are:\n".blue
    puts "1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...\n".red
    puts "By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number then we shall call the word a triangle word.\n".green
    puts "Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?".cyan
  end
end

class TriangleWords
  attr_reader :words
  def initialize(file)
    @word_count = 0
    @words = file.words
  end

  def sum
    self.inject(0) {|sum, item| sum += item}
  end

  def word_count
    @word_count += 1
  end

  def calculate
    @words.each do |word|
      word_sum = 0
      for letter in word.scan(/./)
        word_sum += letter.score
      end
      self.word_count if word_sum.triangular?
    end
  end

  def answer
    self.calculate
    @word_count
  end
end

class Pathway
  def start
    UI.question
    start = Time.now
    words = TriangleWords.new(FileReader.new('p042_words.txt'))
    finish = Time.now
    puts "Calculation took #{finish - start} seconds."
    puts "The answer is #{words.answer}."
  end
end

Pathway.new.start
