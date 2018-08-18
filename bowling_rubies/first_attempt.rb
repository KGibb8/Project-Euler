input = gets.chomp

scores = input.scan(/\d+/)
              .map(&:to_i)
total = 0
is_strike = false
is_spare = false

scores.each_with_index do |current, i|
  last = scores[i - 1]
  first = scores[i + 1]
  second = scores[i + 2]

  if is_spare
    total += current
    is_spare = false
  end

  if current == 10
    is_strike = true
  else
    is_spare = true if [last, current].compact.sum == 10
  end

  if is_strike
    total += [first, second].compact.sum
    is_strike = false
  end

  total += current
end

puts total
