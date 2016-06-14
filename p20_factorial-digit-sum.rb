# n! means n × (n − 1) × ... × 3 × 2 × 1

# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

# Find the sum of the digits in the number 100!

def sum_of_digits_n!(input)
  n = 100
  product = n
  while n > 1
    n -= 1
    product *= n
  end

  string = product.to_s.scan(/./)
  integers = []
  string.each do |x|
    integers.push(x.to_i)
  end

  sum = 0
  integers.each do |x|
    sum += x
  end

  return sum
end
