# 2**15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

# What is the sum of the digits of the number 2**1000?


def sum_2_to_n(n)
  num = 2 ** n
  integers = num.to_s.scan(/./).map {|i| i.to_i}
  integers.inject(0){|sum, item| sum += item}
end
