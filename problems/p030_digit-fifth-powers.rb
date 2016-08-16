
# Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

# 1634 = 1**4 + 6**4 + 3**4 + 4**4
# 8208 = 8**4 + 2**4 + 0**4 + 8**4
# 9474 = 9**4 + 4**4 + 7**4 + 4**4
# As 1 = 1**4 is not a sum it is not included.

# The sum of these numbers is 1634 + 8208 + 9474 = 19316.

# Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.

fifth_powers = []
num = 2
until num == 1000000
  integers = num.to_s.scan(/./).map {|i| i.to_i}
  sum = integers.inject(0) {|sum, item| sum += (item ** 5)}
  fifth_powers << num if sum == num
  num += 1
end

answer = fifth_powers.inject(0) {|sum, item| sum += item}
puts answer
