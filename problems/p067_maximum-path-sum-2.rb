# By starting at the top of the triangle below and moving to adjacent numbers on
# the row below, the maximum total from top to bottom is 23.

# 3
# 7 4
# 2 4 6
# 8 5 9 3

# That is, 3 + 7 + 4 + 9 = 23.

# Find the maximum total from top to bottom in triangle.txt (right click and
# 'Save Link/Target As...'), a 15K text file containing a triangle with
# one-hundred rows.

require './objects/file-reader'

puts "File executed..."

data = FileReader.new('p067_triangle.txt').i_array

def maxsum(data)
  n = -1
  until n == (0 - data.length) # Iterates over outer array
    z = 0
    until z == data[n].length-1 # Iterates over inner array
      sum1 = data[n-1][z] + data[n][z]
      sum2 = data[n-1][z] + data[n][z+1]
      sum1 > sum2 ? data[n-1][z] = sum1 : data[n-1][z] = sum2
#      if sum1 > sum2 # Compares the sum of two branches
#        data[n-1][z] = sum1
#      else
#        data[n-1][z] = sum2
#      end
      z += 1
    end
    n -= 1
  end
  return data[0]
end

start = Time.now

answer = maxsum(data)
puts answer

finish = Time.now

puts "Calculation took #{finish - start} seconds."
