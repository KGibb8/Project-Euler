
# The series, 1**1 + 2**2 + 3**3 + ... + 10**10 = 10405071317.

# Find the last ten digits of the series, 1**1 + 2**2 + 3**3 + ... + 1000**1000.

def self_powers
  n = 1
  sum = 0
  while n <= 1000
    sum += n**n
    n += 1
  end

  answer = []
  series = sum.to_s.scan(/./).map { |i| i.to_i }
  i = series.length-10
  while i <= series.length-1
    answer << series[i]
    i += 1
  end
  return answer.each {|x| print x}
end
