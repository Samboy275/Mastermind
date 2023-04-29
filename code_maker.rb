# frozen_string_literal: true

class CodeMaker
  attr_reader :code

  def initialize(code)
    @code = if code.length == 6
              generate_code(code)
            else
              code.map do |color|
                color
              end

            end
  end

  def rate_guess(guess)
    # this function should return a rating
    rating = ['', '', '', '']
    # cloning the color values to keep unrated colors in check
    rated_colors = []
    guess.each_with_index do |color, index|
      rating[index] = ' '
      if color == @code[index]
        rating[index] = 'perfect'
      elsif @code.include?(color)
        rating[index] = 'exists'
        rating[index] = ' ' if rated_colors.include?(color) && (@code.count(color) == rated_colors.count(color))
      end
      rated_colors.append(color)
    end

    rating
  end

  def generate_code(colors)
    # computer generated code
    generated_code = []
    4.times.map do
      color = colors.sample
      generated_code.append(color)
    end
    puts generated_code
    generated_code
  end
end
