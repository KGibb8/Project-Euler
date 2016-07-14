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
  def abundant?
    divisors = []
    for i in 1..self/2
      divisors << i if self % i == 0
    end
    sum = divisors.inject(0) {|sum, x| sum += x}
    sum > self ? true : false
  end
end

## Treat it like a sieve ##

range = []
for i in 1..28123
  range << i
end

range.each do |x|
  range.delete(x) if x.abundant?
end

# Now we have an array of all non-abundant numbers
# Next step is to eliminate abundant sums
# Find abundants:

abundants = []

for i in 1..28123
  abundants.push(i) if i.abundant?
end

# iterate over abundants deleting sum of x with y from range. If sum > 28123, ignore

abundants.each do |x|
  abundants.each do |y|
    next if x + y >= 28123
    range.delete(x + y)
  end
end
