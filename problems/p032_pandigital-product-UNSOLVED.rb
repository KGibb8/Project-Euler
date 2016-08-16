## We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
## for example, the 5-digit number, 15234, is 1 through 5 pandigital.

## The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and
## product is 1 through 9 pandigital.

## Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through
## 9 pandigital.

## HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

class Finum
  def triangular?
    n = Math.sqrt((8 * self) + 1)
    n % 1 == 0 ? true : false
  end

  def is_pandigital?
    integers = self.to_s.scan(/./).map {|i| i.to_i}
    integers.sort!
    sum = integers.inject(0) {|sum, item| sum += item}
    if sum.triangular?
      puts "is pandigital"
    end

  end
end

# NEARLY

    integers[-1] == (integers.length && pre) ? true : false

# 5 digit no is_pandigital if numbers add to 15
# 10/9 digit is pandigital if numbers add to 45
# is pandigital if sum of numbers is triangular
