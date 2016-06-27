# Let d(n) be defined as the sum of proper divisors of n (numbers less than n
# which divide evenly into n).

# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and
# each of a and b are called amicable numbers.

# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44,
# 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4,
# 71 and 142; so d(284) = 220.

# Evaluate the sum of all the amicable numbers under 10000.

def divisors_of_n(n)
  divisors = []
  for i in 1..sqrt
    if n % i == 0
      divisors.push(n)
    end
  end
  return divisors
end

# d(a) = b

b = divisors(n)
sum_of_b = b.inject(0) { |sum, item| sum += item }

# d(b) = a
a = divisors_of_n(sum_of_b)
sum_of_a = a.inject(0) { |sum, item| sum += item }

# amicable? = If d(a) = b and d(b) = a, where a ≠ b

if sum_of_a != sum_of_b
