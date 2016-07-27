# The decimal number, 585 = 1001001001 (binary), is palindromic in both bases.

# Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

# (Please note that the palindromic number, in either base, may not include leading zeros.)

class String
  def palindrome?
    a = self.to_s
    b = self.to_s.reverse
    a == b
  end
end

both_bases = []
decimal_palindromes = []
n = 1

start = Time.now
until n == 1000000
  decimal_palindromes << n if n.to_s.palindrome?
  n += 1
end

decimal_palindromes.each do |num|
  remainders = {}
  count = 1
  x = num
  until x == 0
    modulo = x % 2
    remainders[count] = modulo
    x = x / 2
    count += 1
  end
  base2 = ""
  remainders.reverse_each{|x,y| base2 << y.to_s}
  both_bases << num if base2.palindrome?
end

sum = both_bases.inject(0) {|sum, item| sum += item}
finish = Time.now
puts "Calculation took #{finish - start} seconds."
puts "The sum of all numbers, less than one million, which are palindromic in base 10 and base 2 is #{sum}."
