
# The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); so
# the first ten triangle numbers are:

# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

# By converting each letter in a word to a number corresponding to its alphabetical
# position and adding these values we form a word value. For example, the word value
# for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number then we
# shall call the word a triangle word.

# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file
# containing nearly two-thousand common English words, how many are triangle words?

Dir.chdir(File.dirname(__FILE__))


class Fixnum
  def triangular?
    num_to_check = (8 * self) + 1
    Math.sqrt(num_to_check) % 1 == 0 ? true : false
  end
end

def gets_words(filename)
  open filename do |file|
    while line = file.gets
      line.gsub!(/"\,"/, " ")
      line.gsub!(/^\"|\"?$/, '')
      words = line.split
    end
    words
  end
end

word_count = 0
words = gets_words('p042_words.txt')
words.each do |word|
  letters = word.scan(/./)
  numbers = []
  for letter in letters
    number = (letter.ord - 64)
    numbers << number
  end
  sum_of_word = numbers.inject(0) {|sum, item| sum += item}
  word_count += 1 if sum_of_word.triangular?
end

puts word_count
