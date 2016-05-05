class Primes
  def nth_prime(input)
    n = 1
    primes = []
    until input <= primes.length
        n += 1
        is_prime = true
        if n == 1
            is_prime = false
        end

        for i in 2..n-1
            if n % i == 0
                is_prime = false
            end
        end

        if is_prime == true
            primes.push(n)
        end
    end
    primes.each do |item|
    		puts "#{item}"
    end
    puts primes[input-1]
  end
end
