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
    rating = ['','','','']
    rated = []

    guess.each_with_index do |color, index|
      if @code[index] == color
        rating[index] = 'perfect'
        rated.append(index)
    end


    guess.each_with_index do |color, index|
    next if rated.include?(index)

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
