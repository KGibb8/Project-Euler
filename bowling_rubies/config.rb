require 'ostruct'

module Config
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def config
      @config.to_h
    end

    def configure
      @config = (@config || OpenStruct.new).tap { |config| yield(config) }
    end
  end
end
