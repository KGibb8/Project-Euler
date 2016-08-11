def log_results(filename)
  output = File.open(filename,"w")
  output << self.join("\n")
  output.close
end

hands = []
hands.collect{|round| round.collect{|cards| player = Hand.new(cards); hands << player.determine_best_hand}}
hands.log_results('p54_handslog.txt')
