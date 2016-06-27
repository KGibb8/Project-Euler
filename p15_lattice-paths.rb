# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down,
# there are exactly 6 routes to the bottom right corner.
# How many such routes are there through a 20×20 grid?


def factorial(n)
  if n == 0
    return 1
  end
  product = n
  while n > 1
    n -= 1
    product *= n
  end
  return product
end

def routes(n)
  x = factorial(n*2) / (factorial(n) * factorial(n))
  puts "Starting in the top left corner only being able to move to the right and down, a #{n} by #{n} grid has #{x} routes."
  return x
end
