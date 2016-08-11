
class UI
  def self.introduction
    filename = './lib/user-interface/text-art/intro.txt'
    open filename do |file|
      while line = file.gets
        puts line
      end
    end
  end

  def self.gets_players
    puts "How many players are there?"
    participants = gets.chomp
    puts "Enter the name of each player (press ENTER after each player)."
    players = []
    (1..participants.to_i).each { players << gets.chomp }
    return players
  end

  def self.begin_game
    puts "Let the games begin!\n"
    puts "DECK INITIALIZED\n"
  end

end
