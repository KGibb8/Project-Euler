# A number chain is created by continuously adding the square of the digits in a
# number to form a new number until it has been seen before.

# For example,

# 44 → 32 → 13 → 10 → 1 → 1
# 85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89

# Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop.
# What is most amazing is that EVERY starting number will eventually arrive at 1 or 89.

# How many starting numbers below ten million will arrive at 89?

def chain
  integers = self.to_s.scan(/./).map {|i| i.to_i}
  chain = integers.inject(0) {|sum, item| square = item ** 2; sum += square}
end

count = 10000000
x = 2
until x == 10000000
  num = x.chain
  until num == 89
    num = num.chain
    if num == 1
      count -= 1
      puts count
      break
    end
  end
  x += 1
end

start = Time.now
count = 0
x = 2
until x == 10000000
  num = x.chain
  until num == 89
    num = num.chain
    break if num == 1
    if num == 89
      count += 1
      break
    end
  end
  x += 1
  print "#{x} "
end
finish = Time.now
puts "Calculation took #{finish - start} seconds."


count = 0
dead_end = [1, 44, 32, 13, 10]
x = 2
until x == 10000000
  num = x
  round = []
  until num == 89 || 1
    num = num.chain
    round << num
    round.map {|i| dead_end << i} if num == 1
  end
  count += 1 unless dead_end.include? x
  x += 1
end

# Dynamic solution:

# You can save the numbers as you go for each iteration,
# if it ends in 1, append all numbers to dead_end
# Check if x is in dead_end => if its not it ends in 89

# WILL THIS WORK OR DOES IT MISS OUT NUMBERS?

start = Time.now
count = 0
x = 2
eighty_nines = [89, 85, 145, 42, 20, 4, 16, 37, 58, 89, 25, 29, 34, 53, 146]
ones = [1, 44, 32, 13, 10]
until x == 10000000
  num = x.chain
  round = []
  until num == 89
    num = num.chain
    round << num
    if ones.include? num
      round.map {|i| ones << i}
      break
    end
    if eighty_nines.include? num
      round.map {|i| eighty_nines << i}
      count += 1
      break
    end
  end
  x += 1
  print "#{x} "
end
finish = Time.now
puts "Calculation took #{finish - start} seconds."

# Takes even longer => checks an ever increasingly long array,
# Doubles up appending ones + eighty_nines with same results
