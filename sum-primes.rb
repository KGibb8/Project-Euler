#The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

#Find the sum of all the primes below two million.

class Primes
  def self.sum_to(limit)
    start = Time.now
    sum = 2
    n = 1
    while n < limit
        n += 1
        is_prime = true
        if n == 1
            is_prime = false
            next
        end

        if n.even?
          is_prime = false
          next
        end

        for i in 2..Math.sqrt(n)
            if n % i == 0
                is_prime = false
            end
        end

        if is_prime == true
            sum += n
        end
    end
    finish = Time.now
    "Calculation took #{finish - start} seconds"
    return sum
  end
end
