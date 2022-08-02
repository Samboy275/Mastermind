
# class for the code maker
class CodeMaker
  # 1 - take code maker input to make a code out of a fixed amount of colors
  # 2 - take in code breaker guess and rate it
  # 3 - return an array rating the player guesses if all are perfect game ends
  include Game
  attr_reader :code

  def initialize(code)
    @code = code.split('-').map do |index|
      Game::COLORS[index.to_i - 1]
    end
  end

  def rate_guess(guess)
    rating = ['', '', '', '']
    code.each_with_index do |color, index|
      rating[index] = if color == guess[index]
                        'perfect'
                      elsif code.include? guess[index]
                        'exists'
                      end
    end
    rating.shuffle
  end
end

class AICodeMaker < CodeMaker
  def initialize
    @code = generate_code
  end

  private
  def generate_code
    4.times.map {
      Game::COLORS.sample
    }
  end
end
