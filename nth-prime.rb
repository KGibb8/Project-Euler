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
        # break if count == input
        primes.push(n)
      end
      # count += 1
    end
    finish = Time.now
    puts "Calculation took #{finish - start} seconds"
    return primes[input-1]
  end


  #############################################################
  ###################### ANOTHER METHOD #######################
  #############################################################


    def nth_primeO(input)
      start = Time.now
      n = 0
      count = 0
      loop do
        n += 1
        next if n == 1

        if n == 2
          count += 1
          break if count == input
          next
        end

        next if n.even?

        for i in 2..Math.sqrt(n)
          if n % i == 0
            is_prime = false
          end
        end

        next if is_prime == false

        count += 1
        break if count == input
      end
      finish = Time.now
      puts "Calculation took #{finish - start} seconds"
      return n
    end
end
