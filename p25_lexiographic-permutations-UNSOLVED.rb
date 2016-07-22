
# A permutation is an ordered arrangement of objects. For example, 3124 is one
# possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
# are listed numerically or alphabetically, we call it lexicographic order. The
# lexicographic permutations of 0, 1 and 2 are:

# 012   021   102   120   201   210

# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5,
# 6, 7, 8 and 9?

permutations = []
integers = ["0","1","2","3","4","5","6","7","8","9"]

permutations << integers.inject("") {|string, item| string += item}

def swap(a, b)
  a, b = b, a
end






# Take numbers to rearrange in sets starting with last 2 , trying out each combination, introducing one at a time until 10th digit.

0123456789
0123456798
0123456978
0123456987
0123456879
0123456897

0123457689
0123457698
0123457869
0123457896
0123457968
0123457986
