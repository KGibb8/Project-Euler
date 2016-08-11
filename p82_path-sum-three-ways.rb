# The minimal path sum in the 5 by 5 matrix below, by starting in any cell in the
# left column and finishing in any cell in the right column, and only moving up,
# down, and right, is indicated in red and bold; the sum is equal to 994.

# 131 673 234 103 18
# 201 96  342 965 150
# 630 803 746 422 111
# 537 699 497 121 956
# 805 732 524 37  331

# Find the minimal path sum, in matrix.txt (right click and "Save Link/Target As..."),
# a 31K text file containing a 80 by 80 matrix, from the left column to the right column.

require './file-reader'

grid = FileReader.new('p081_matrix.txt').i_array

So with 2 sum path

121 -- 956
 |      |
 37 -- 331


With 3 sum path

746    422    111

497    121    956

524    37     331

# We don't know where we are finishing, but we know it must be one of the far right hand side
# So starting with the bottom right corner and doing the same for each starting point up to the top right
# First move we have only two options so same as normal
# Second move we have still only two options --> only until we change to a different row + column do we have 3 options

# Starting at other points, along the right side, we must sum
