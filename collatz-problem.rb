# The following iterative sequence is defined for the set of positive integers:

# n → n/2 (n is even)
# n → 3n + 1 (n is odd)

# Using the rule above and starting with 13, we generate the following sequence:

# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms.
# Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

# Which starting number, under one million, produces the longest chain?

def even(n)
  if n % 2 == 0
    even = true
  else
    even = false
  end
end

start = Time.now

n = 14
outer = []
until n == 1000000
    a = n
    inner = []
    while n > 1
      if even(n)
        n = n / 2
        inner.push(n)
      else
        n = (3 * n) + 1
        inner.push(n)
      end
    end
    outer.push([inner.length, a])
    n = a + 1
  puts n
end

result = outer.sort_by {|x, y| x}
result[result.length-1]

finish = Time.now
"Calculation took #{finish - start} seconds"

# Better way of doing is not having array but checking to see if the new value for n is greater than the previous one.
# Have a counter instead of array.



# The answer is a, when inner.length has the highest value
# How do you extract a without jumbling up all of your arrays?


start = Time.now

n = 14
until i == 1000000
    a = n
    chain = 1 # no. of numbers in sequence
    b = 1
    while n > 1
      if even(n)
        n = n / 2
        chain += 1
      else
        n = (3 * n) + 1
        chain += 1
      end
    end
    if chain > b
      b = chain
    end



    i += 1

    n = a + 1
  puts n
end
puts a

finish = Time.now
"Calculation took #{finish - start} seconds"
