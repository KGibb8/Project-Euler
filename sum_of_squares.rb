# The sum of the squares of the first ten natural numbers is,

# 1sq + 2sq + ... + 102 = 385
# The square of the sum of the first ten natural numbers is,

# (1 + 2 + ... + 10)sq = 552 = 3025
# Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.

# Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

puts "Find the difference between the sum of the squares and the square of the sum of the first 'n' numbers"
puts "Define 'n'"
n = gets.chomp
integers = []
n = Integer(n)

for num in 1..n
  integers.push(num)
end

total = 0
integers.each do | num |
  x = num ** 2
  total += x
end

puts "Sum of the Squares: #{total}"

total2 = 0
integers.each do | num |
  x = num
  total2 += x
end

puts "Square of the Sum: #{total2 ** 2}"

finaltotal = (total2 ** 2) - total

puts "Difference: #{finaltotal}"
