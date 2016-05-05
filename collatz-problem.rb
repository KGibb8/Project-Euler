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
# Temporarily store a value in a variable
