# A palindromic number reads the same both ways.
# The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.


def is_palindrome(str)
  str.to_s == str.to_s.reverse!
end

palindromes = []
999.downto(100) do |i|
  999.downto(100) do |n|
    p = n * i
    if is_palindrome(p)
      puts "#{p} is a palindrome"
      palindromes.push(p)
    end
  end
end

palindromes.sort!
puts palindromes[palindromes.length-1]
