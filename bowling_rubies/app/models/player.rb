# frozen_string_literal: true

require_relative "./application_record"

class Player < ApplicationRecord
  attr_reader :turns,
              :name

  def initialize(name)
    @name = name
    @turns = []
  end

  def score
    turns.sum(&:score)
  end

  def bowl!
    Turn.new.tap do |turn|
      turn.player = self
      @turns << turn
    end
  end
end
