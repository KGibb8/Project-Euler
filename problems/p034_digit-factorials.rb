# REMEMBER ----> n! means n × (n − 1) × ... × 3 × 2 × 1

# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

# Find the sum of all numbers which are equal to the sum of the factorial of their digits.

# Note: as 1! = 1 and 2! = 2 are not sums they are not included.



def factorial(n)
  if n == 0
    return 1
  end
  product = n
  while n > 1
    n -= 1
    product *= n
  end
  return product
end

curious = []
start = Time.now
sumOfFacts = 0
num = 3
while num < 999999
  integers = num.to_s.scan(/./).map {|x| x.to_i}
  sum = 0
  integers.each do |x|
    sum += factorial(x)
  end

## see comment below

  if sum == num
    sumOfFacts += num
  end

  num += 1
end

finish = Time.now
puts sumOfFacts
puts "Calculation took #{finish - start} seconds."

### REPLACE CODE FROM MARKER ABOVE WITH BELOW TO SEE THE CURIOUS NUMBERS ###

if sum == num
  curious.push(num)
end

num += 1
end

finalsum = 0
curious.each do |x|
  finalsum += x
end
puts finalsum
finish = Time.now
