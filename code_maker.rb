# frozen_string_literal: true

# class for the code maker
class CodeMaker
  # 1 - take code maker input to make a code out of a fixed amount of colors
  # 2 - take in code breaker guess and rate it
  # 3 - return an array rating the player guesses if all are perfect game ends

  attr_reader :code

  def initialize(code)
    @code = code.split('-').map do |index|
      Game::COLORS[index.to_i - 1]
    end
  end

  def rate_guess(guess)
    rating = { perfect: 0, exists: 0}
    rated = {@code[0] => false, @code[1] => false, @code[2] => false, @code[3] => false}
    @code.each_with_index do |color, index|
      if color == guess[index]
        rating[:perfect] += 1
      elsif code.include? guess[index] && !rated[color]
        rating[:exists] += 1
        rated[color] = true
      end
    end
    rating
  end
end

class AICodeMaker < CodeMaker
  def initialize(colors)
    @code = generate_code(colors)
  end

  private

  def generate_code(colors)
    code = []
    4.times.map do
      color = 'c'
      color = colors.sample until !code.include?(color) && color != 'c'
      code.append(color)
    end
    code
  end
end
