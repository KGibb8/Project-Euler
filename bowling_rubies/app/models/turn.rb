# frozen_string_literal: true

require_relative './application_record'

class Turn < ApplicationRecord
  attr_accessor :player

  def initialize
    @bowl_1 = bowl
    @bowl_2 = @bowl_1 < 10 ? bowl : 0
    @score = nil
  end

  def score
    @score ||= bowls.sum
  end

  def strike?
    score.ten? &&
      bowl_1.ten? &&
      bowl_2.zero?
  end

  def spare?
    bowl_1 < 10 &&
      score.ten?
  end

  private

  attr_reader :bowls,
              :bowl_1,
              :bowl_2

  def bowl
    rand(10)
  end

  def bowls
    [bowl_1, bowl_2]
  end
end
