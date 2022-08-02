# frozen_string_literal: true

# module to manage the game
module Game
  COLORS = %w[blue yellow red green orange purple].freeze
  TURNS = 6
  def self.new_game(code)
    @code = code.split('-')
  end

  def self.update
    (1..6).each do |i|
      puts i
    end
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
# puts "make a 4 color code out of #{Game::COLORS.each_with_index.map do |color, index|
#   "#{index + 1}- #{color}"
# end.join(' ')} using the colors numbers"
# print 'input the numbers in this pattern #-#-#-#: '
# player_code = ''
# player_code = gets.chomp until player_code.match?(/[0-9]-[0-9]-[0-9]-[0-9]/)
# code_maker = CodeMaker.new(player_code)

# puts code_maker.code
# print 'input the guess in this pattern color-color-color-color: '
# guess = ''
# guess = gets.chomp until guess.match?(/[a-z]+-[a-z]+-[a-z]+-[a-z]+/i)
# guess = guess.split('-')
# puts code_maker.rate_guess(guess)
Game.update

comp = AICodeMaker.new

puts comp.code
