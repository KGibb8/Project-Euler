# By starting at the top of the triangle below and moving to adjacent numbers
# on the row below, the maximum total from top to bottom is 23.

#    3
#   7 4
#  2 4 6
# 8 5 9 3

# That is, 3 + 7 + 4 + 9 = 23.

# Find the maximum total from top to bottom of the triangle below:

#                       75
#                     95 64
#                    17 47 82
#                  18 35 87 10
#                20 04 82 47 65
#               19 01 23 75 03 34
#              88 02 77 73 07 63 67
#            99 65 04 28 06 16 70 92
#          41 41 26 56 83 40 80 70 33
#         41 48 72 33 47 32 37 16 94 29
#        53 71 44 65 25 43 91 52 97 51 14
#      70 11 33 28 77 73 17 78 39 68 17 57
#     91 71 52 38 17 14 91 43 58 50 27 29 48
#   63 66 04 68 89 53 67 30 73 16 69 87 40 31
#  04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

# NOTE: As there are only 16384 routes, it is possible to solve this problem by
# trying every route. However, Problem 67, is the same challenge with a triangle
# containing one-hundred rows; it cannot be solved by brute force, and requires
# a clever method! ;o)

# Start in the bottom corner

#   a
# b  c

# a + b <=> a + c
# compare sums, choose greater.
# iterate along arrays, summing totals.
# eventually reach the top of triangle, gives greatest sum

a = [63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31]
b = [04, 62, 98, 27, 23, 9, 70, 98, 73, 93, 38, 53, 60, 04, 23]

n = 0
while n < a.length
  sum1 = a[n] + b[n]
  sum2 = a[n] + b[n+1]
  if sum1 > sum2
    a[n] = sum1
  else
    a[n] = sum2
  end
  n += 1
end


##################################


a = [75]
b = [95, 64]
c = [17, 47, 82]
d = [18, 35, 87, 10]
e = [20, 04, 82, 47, 65]
f = [19, 01, 23, 75, 03, 34]
g = [88, 02, 77, 73, 07, 63, 67]
h = [99, 65, 04, 28, 06, 16, 70, 92]
i = [41, 41, 26, 56, 83, 40, 80, 70, 33]
j = [41, 48, 72, 33, 47, 32, 37, 16, 94, 29]
k = [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14]
l = [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57]
m = [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48]
n = [63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31]
o = [04, 62, 98, 27, 23, 9, 70, 98, 73, 93, 38, 53, 60, 04, 23]

data = [[75], [95, 64], [17, 47, 82], [18, 35, 87, 10], [20, 04, 82, 47, 65], [19, 01, 23, 75, 03, 34], [88, 02, 77, 73, 07, 63, 67], [99, 65, 04, 28, 06, 16, 70, 92], [41, 41, 26, 56, 83, 40, 80, 70, 33], [41, 48, 72, 33, 47, 32, 37, 16, 94, 29], [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14], [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57], [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48], [63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31], [04, 62, 98, 27, 23, 9, 70, 98, 73, 93, 38, 53, 60, 04, 23]]

# data[n] is same as 'a'

n = -1
until n == (0 - data.length)
  z = 0
  until z == data[n].length-1
    sum1 = data[n-1][z] + data[n][z]
    sum2 = data[n-1][z] + data[n][z+1]
    if sum1 > sum2
      data[n-1][z] = sum1
    else
      data[n-1][z] = sum2
    end
    z += 1
  end
  n -= 1
end
