
# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

integers = []

for num in 1..20
  integers.push(num)
end


n = 2520
foo = true
while foo
  sum = 0
  n += 20
  modulos = []

  for i in integers
      modulos.push(n % i)
  end

  modulos.each do | num |
    sum += num
  end
  
  if sum == 0
    foo = false
    puts n
  end
end
