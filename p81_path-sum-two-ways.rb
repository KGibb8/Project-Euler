# In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom
# right, by only moving to the right and down, is indicated in bold red and is equal to 2427.

# 131 673 234 103 18
# 201 96  342 965 150
# 630 803 746 422 111
# 537 699 497 121 956
# 805 732 524 37  331

# Find the minimal path sum, in matrix.txt (right click and "Save Link/Target As..."),
# a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right
# by only moving right and down.

require './file-reader'

grid = FileReader.new('p081_matrix.txt').i_array

# FIRST ANSWER == INCORRECT

def minsum_path
  x = self.size-1
  y = self.size-1
  until x == 0 && y == 0
    if x == 0
      sum2 = self[x][y] + self[x][y-1]
      self[x][y+1] = sum2
      y -= 1
      next
    end
    if y == 0
      sum1 = self[x][y] + self[x-1][y]
      self[x-1][y] = sum1
      x -= 1
      next
    end

    sum1 = self[x][y] + self[x-1][y]
    sum2 = self[x][y] + self[x][y-1]
    if sum1 < sum2
      self[x-1][y] = sum1
      x -= 1
    else
      self[x][y-1] = sum2
      y -= 1
    end
  end
  self[x][y]
end

grid.minsum_path


# Not a dynamic algorithm, just finds the minsum_path based on each decision,
# not based on all possible decisions.

# More possibility of lower sums on alternate routes.
# Just because you chose the lower sum at a 2 way fork, doesn't mean the difference
# isn't made up elsewhere by taking the higher sum then for the sake of an even
# lower sum later...

# the algorithm has chosen the wrong path because it only takes into account two
# options at a time, we need it to visit every number at least once, to take into
# account the entire grid, not just a narrow pathway through the middle.
# To do so we need it to sum the bottom row, then sum the rightmost column,
# then we find the [x,y].min of the next row, work along the row until 0,
# then move up a column, find the [x,y].min of the next row, and so on
# until we have the answer. By doing this we work out all minsum pathways
# concurrently but the lowest always wins out, due to [x,y].min.

# SECOND ANSWER == CORRECT

require './file-reader'

grid = FileReader.new('p081_matrix.txt').i_array


def minsumpath
  # sums bottom row + rightmost column
  x = self.size-1
  y = self.size-2
  loop do
    self[x][y] += self[x][y+1]
    self[y][x] += self[y+1][x]
    break if y == 0
    y -= 1
  end

  # find the [x,y].min of each item, row by row moving through columns
  x = self.size-2
  loop do
    y = self.size-2
    loop do
      self[x][y] += [self[x+1][y], self[x][y+1]].min
      break if y == 0
      y -= 1
    end
    break if x == 0
    x -= 1
  end

  return self[x][y]
end

grid.minsumpath
