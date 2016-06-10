# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

# What is the 10 001st prime number?

class Primes
  def nth_prime(input)
    start = Time.now
    n = 0
    primes = []
    until input <= primes.length
      n += 1
      is_prime = true
      if n == 1
        is_prime = false
        next
      end

      if n == 2
        is_prime = true
        primes.push(n)
        next
      elsif n.even?
        is_prime = false
        next
      end

      for i in 2..Math.sqrt(n)
        if n % i == 0
            is_prime = false
        end
      end

      if is_prime == true
        primes.push(n)
      end
    end
    finish = Time.now
    "Calculation took #{finish - start} seconds"
    puts primes[input-1]
  end
end
