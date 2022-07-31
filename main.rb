# frozen_string_literal: true

module Game
  COLORS = %w[blue yellow red green orange purple].freeze
  def self.new_game(code)
    @code = code.split('-')
  end
end

# class for the mastermind game
class Mastermind
  # declare availabe colors
  COLORS = %w[blue yellow red green orange purple].freeze
  # getters for instance objects
  attr_reader :code, :COLORS, :rating
  # instance variables
  @rating  = ['','','','']
  def initialize(player_code)
    # take the code and and seperate it to make the code
    @code = player_code.split('-').map do |item|
      COLORS[item.to_i - 1]
    end
  end

  # rate the codebreaker input
  def rate_guess(guess)
    rating = ['', '','','']
    availabe = [1,2,3,4]
    code.each_with_index{ |color, index|
      if guess.include? color
        i = availabe.sample
        availabe.delete(i)
        if index == guess.index(color)
          rating[i] = 'perfect'
        else
          rating[i] = 'exists'
        end
      end
    }
    rating
  end

end
puts "make a 4 color code out of #{Game::COLORS.each_with_index.map do |color, index|
  "#{index + 1}- #{color}"
end.join(' ')} using the colors numbers"

player_code = ''
player_code = gets.chomp until player_code.match?(/[0-9]\-[0-9]\-[0-9]\-[0-9]/)
game = Mastermind.new(player_code)

puts game.code


puts 'Enter your guess seperated with spaces'

guess = gets.chomp.split(' ')

puts game.rate_guess(guess)
