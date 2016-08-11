
# An irrational decimal fraction is created by concatenating the positive integers:

# 0.123456789101112131415161718192021...

# It can be seen that the 12th digit of the fractional part is 1.

# If dn represents the nth digit of the fractional part, find the value of the following expression.

# d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

###### BRUTE FORCE SOLUTION #####

array = []
n = 1
while n <= 1000000
  array << n
  n += 1
end

array.collect do |x|
  array[x-1] = x.to_s.scan(/./)
end

digits = array.flatten

=begin
digits = []
array.each do |x|
  x.collect do |y|
    digits << y
  end
end
=end
digits[0].to_i * digits[9].to_i * digits[99].to_i * digits[999].to_i * digits[9999].to_i * digits[99999].to_i * digits[999999].to_i
