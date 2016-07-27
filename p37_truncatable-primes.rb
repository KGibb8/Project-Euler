# The number 3797 has an interesting property. Being prime itself, it is possible
# to continuously remove digits from left to right, and remain prime at each stage:
# 3797, 797, 97, and 7.

# Similarly we can work from right to left:
# 3797, 379, 37, and 3.

# Find the sum of the only eleven primes that are both truncatable from left to
# right and right to left.

# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

class Fixnum
  def is_prime?
    is_prime = true

    if self == 1
      is_prime = false
    end

    if self == 2
      is_prime = true
    elsif self.even?
      is_prime = false
    end

    for i in 2..Math.sqrt(self)
      if self % i == 0
        is_prime = false
      end
    end

    return is_prime
  end
end

truncatable = []

x = 8
until truncatable.length == 11
  if x.is_prime?
    integers = x.to_s.scan(/./).map {|i| i.to_i}
    to_check = []
    n = 1
    to_check << integers[0]
    until n == integers.length

      # Right to left
      string = ""
      number = integers[0..integers.length-n]
      number.map {|i| string << i.to_s}
      to_check << string.to_i

      # Left to right
      string = ""
      number = integers[-n..-1]
      number.map {|i| string << i.to_s}
      to_check << string.to_i

      n += 1
    end

    count = 0
    to_check.uniq!
    to_check.each {|i| count += 1 if i.is_prime?}
    truncatable << x if count == to_check.length
  end
  x += 1
end

answer = truncatable.inject(0) {|sum, item| sum += item}
puts answer
