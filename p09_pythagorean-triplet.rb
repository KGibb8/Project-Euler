## A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

## a2 + b2 = c2
## For example, 32 + 42 = 9 + 16 = 25 = 52.

## There exists exactly one Pythagorean triplet for which a + b + c = 1000.
## Find the product abc.

sum = 1000
(1..sum/3).each do |a|
  (a..sum/2).each do |b|
    c = sum - a - b
    if (a*a)+(b*b) == c*c
      product = a*b*c
      puts product
    end
  end
end
