# frozen_string_literal: true

class Array
  accessors = [
    :first, :second, :third,
    :fourth, :fifth, :sixth,
    :seventh, :eighth, :ninth,
    :tenth
  ]

  accessors.each_with_index do |method_sym, i|
    define_method method_sym do
      self[i]
    end
  end
end

