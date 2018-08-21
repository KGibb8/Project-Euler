require 'pry'

class Shoes
  class << self
    def app(config)
      puts "starting app"
      puts "loading config #{config}"
    end

    def url(path, action)
      puts "building '#{path}' with :#{action}"
    end
  end
end
