# The prime factors of 13195 are 5, 7, 13 and 29.

# What is the largest prime factor of the number 600851475143 ?

n = 600851475143
d = 2

until n == 1
  i = n % d
  if i != 0
    d += 1
  else
    n = n / d
  end

  if n == 1
    puts d
  end
end
