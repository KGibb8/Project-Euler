
require './lib/pathway'
require './lib/generators/year_generator'
require './lib/generators/calendar_generator'
require './lib/user_interface/ui'

calendar = Pathway.new
calendar.execute
