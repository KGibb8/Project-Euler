
# A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:

# 1/2	= 	0.5
# 1/3	= 	0.(3)
# 1/4	= 	0.25
# 1/5	= 	0.2
# 1/6	= 	0.1(6)
# 1/7	= 	0.(142857)
# 1/8	= 	0.125
# 1/9	= 	0.(1)
# 1/10	= 	0.1
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.

# Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.

decimals = []

d = 2
loop do
  float = 1.0 / d
  array = float.to_s.scan(/./)
  floats = []
  array[2..array.length].each { |i| floats << i.to_i }
  decimals << floats
  d += 1
  break if d == 1000
end

# .map(&:first) is same as writing .map {|i| i.first}
# ary.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)

decimals[12].group_by{ |e| e }
# this groups numbers them into hash. Key is the number, value is array of all items that occur. Repeating values added into array.
decimals[12].group_by{ |e| e }.select { |k, v| v.size > 1 }
# looks through hash, if key.size (length of Array of repeating items) is greater than one, select that item
decimals[12].group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
decimals[12].group_by{ |e| e }.select { |k, v| v.size > 1 }.map {|i| i.first}
decimals[12].group_by{ |e| e }.select { |k, v| v.size > 1 }.map {|i, v| i }
# map keys from hash of repeating values to new array.
# THIS IS NOT SOLUTION
