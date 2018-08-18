# Attempt 2

class Integer
  def ten?
    self == 10
  end
end

class Array
  def strike?
    self.count == 2 &&
      self[0].ten? &&
      self[1].zero?
  end

  def spare?
    self.count == 2 &&
      self.first < 10 &&
      self.sum.ten?
  end
end

input = gets.chomp
scores = input.scan(/\d+/).map(&:to_i)
total = 0

scores.each_with_index do |num, i|
  scores.insert(i + 1, 0) if num.ten?
end

rounds_enum = scores.each_slice(2)
rounds = rounds_enum.to_a

rounds_enum.with_index do |round, i|
  total += round.sum
  next_round = rounds[i + 1]

  if next_round
    total += next_round.sum if round.strike?
    total += rounds.to_a[i + 1].first if round.spare?
  end
end

puts total
puts "\n\n----------------------------\n\n"
