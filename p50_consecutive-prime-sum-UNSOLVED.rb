# The prime 41, can be written as the sum of six consecutive primes:

# 41 = 2 + 3 + 5 + 7 + 11 + 13
# This is the longest sum of consecutive primes that adds to a prime below one-hundred.

# The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.

# Which prime, below one-million, can be written as the sum of the most consecutive primes?

class Fixnum
  def is_prime?
    is_prime = true

    if self == 1
      is_prime = false
      end

      if self == 2
        is_prime = true
      elsif self.even?
        is_prime = false
      end

      for i in 2..Math.sqrt(self)
        if self % i == 0
        is_prime = false
      end
    end

    return is_prime
  end
end

primes = []
n = 1
while n < 1000
  primes << n if n.is_prime?
  n += 1
end

sum = 0
unless sum >= 1000
  primes.each {|item|}
    sum += item
  end
end
