
require './lib/user-interface/ui'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

game = Poker.new
game.start
