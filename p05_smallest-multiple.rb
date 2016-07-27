integers = []

for num in 1..20
  integers.push(num)
end


n = 2520
sum = 1
until sum == 0
  sum = 0
  n += 20
  modulos = []

  for i in integers
      modulos.push(n % i)
  end

  modulos.each do | num |
    sum += num
  end
  
end

puts n
