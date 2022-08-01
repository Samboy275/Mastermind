# frozen_string_literal: true

module Game
  COLORS = %w[blue yellow red green orange purple].freeze
  def self.new_game(code)
    @code = code.split('-')
  end
end

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

# class for code breaker
class CodeBreaker
  # 1 - initialize a codebreaker object with number of tries
  # 2 - make a guess function that takes and stores the breaker guess
  attr_reader :tries, :guess

  def initialize
    @guess = ''
    @tries = 6
  end

  def guess=(guess)
    @guess = guess.split('-')
  end
end
puts "make a 4 color code out of #{Game::COLORS.each_with_index.map do |color, index|
  "#{index + 1}- #{color}"
end.join(' ')} using the colors numbers"
print 'input the numbers in this pattern #-#-#-#: '
player_code = ''
player_code = gets.chomp until player_code.match?(/[0-9]-[0-9]-[0-9]-[0-9]/)
code_maker = CodeMaker.new(player_code)

puts code_maker.code
print 'input the guess in this pattern color-color-color-color: '
guess = ''
guess = gets.chomp until guess.match?(/[a-z]+-[a-z]+-[a-z]+-[a-z]+/i)
guess = guess.split('-')
puts code_maker.rate_guess(guess)
