# A perfect number is a number for which the sum of its proper divisors is
# exactly equal to the number. For example, the sum of the proper divisors of 28
# would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

# A number n is called deficient if the sum of its proper divisors is less than
# n and it is called abundant if this sum exceeds n.

# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
# number that can be written as the sum of two abundant numbers is 24. By
# mathematical analysis, it can be shown that all integers greater than 28123
# can be written as the sum of two abundant numbers. However, this upper limit
# cannot be reduced any further by analysis even though it is known that the
# greatest number that cannot be expressed as the sum of two abundant numbers
# is less than this limit.

# Find the sum of all the positive integers which cannot be written as the sum
# of two abundant numbers.

class Integer
  def abundant
    divisors = []
    for i in 1..self/2
      divisors << i if self % i == 0
    end
    sum = divisors.inject(0) {|sum, x| sum += x}
    sum > self ? self : nil
  end
end

start = Time.now

# Create range:

limit = 28123
range = []

for i in 1..limit
  range << i
end

# Find abundants:

abundants = []

for i in 1..limit
  a = i.abundant
  abundants << a if a != nil
end

# Find abundant sums:

abundant_sums = []
abundants.each do |x|
  abundants.each do |y|
    if x + y <= limit
      abundant_sums << x + y
    else
      break
    end
  end
end

# Remove recurring values

abundant_sums.uniq!

# Remove abundant sums from range:

abundant_sums.each do |x|
  range.delete(x) if range.include? x
end

# Sum range:

sum = 0
for i in range
  sum += i
end

finish = Time.now
puts "Calculation took #{finish - start} seconds.\n"
puts "The sum of all non-abundant-sum positive integers is #{sum}.\n"
