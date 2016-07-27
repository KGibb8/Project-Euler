
# In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:

# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# It is possible to make £2 in the following way:

# 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
# How many different ways can £2 be made using any number of coins?

class CoinSet
  attr_reader :coins
  def initialize
    @coins = [self.one_p, self.two_p, self.five_p, self.ten_p, self.twenty_p, self.fifty_p, self.one_pound, self.two_pounds]
  end

  def one_p; 1 end
  def two_p; 2 end
  def five_p; 5 end
  def ten_p; 10 end
  def twenty_p; 20 end
  def fifty_p; 50 end
  def one_pound; 100 end
  def two_pounds; 200 end
end

routes = 0
total = 0
until total == 200
  total += pocket.one_p
  routes += 1
end

pocket = CoinSet.new

coins = [200, 100, 50, 20, 10, 5, 2, 1]

routes = 0
loop do
  sum = 0
  until sum == 200
    coins.each do |x|
      sum += x
      break if sum == 200
    routes += 1 if sum == 200
  end
end
