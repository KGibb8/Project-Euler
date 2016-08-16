# Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:

# 21 22 23 24 25
# 20  7  8  9 10
# 19  6  1  2 11 28 54 86
# 18  5  4  3 12
# 17 16 15 14 13

# It can be verified that the sum of the numbers on the diagonals is 101.

# What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?

sum = 1
side = 1
until side == 1001
  bottom_right = side ** 2 + (side + 1)
  bottom_left = side ** 2 + 2 * (side + 1)
  top_left = side ** 2 + 3 * (side + 1)
  side += 2
  top_right = side ** 2
  sum += (top_right + bottom_right + bottom_left + top_left)
end
puts sum
