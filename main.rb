# frozen_string_literal: true
require './code_maker'
require './code_breaker'
# module to manage the game
module Game
  COLORS = %w[blue yellow red green orange purple].freeze
  TURNS = 6
  def self.new_game(code)
    @code = code.split('-')
  end

  def self.update
    while true
      player_won = ''
      puts "Enter 1 to be code maker or 2 to be code breaker\n"
      choice  = gets.chomp.to_i
      player = 'none'
      ai = 'none'
      if choice == 1
        player_won = true
        puts "make a 4 color code out of #{Game::COLORS.each_with_index.map do |color, index|
        "#{index + 1}- #{color}"
        end.join(' ')} using the colors numbers"
        print 'input the numbers in this pattern #-#-#-#: '
        player_code = ''
        player_code = gets.chomp until player_code.match?(/[0-9]-[0-9]-[0-9]-[0-9]/)
        player = CodeMaker.new(player_code)
        ai = AICodeBreaker.new()
      else
        player = CodeBreaker.new()
        player_won = false
        ai = AICodeMaker.new(Game::COLORS)
        puts ai.code
      end

      TURNS.times do
        if (player.is_a? CodeMaker)
          guess = ai.make_guess(Game::COLORS)
          puts guess
          rating = player.rate_guess(guess)
          if  rating.count('perfect') == 4
            player_won = false
            break
          end
          ai.check_rating(rating)
        else
          puts "Enter your prediction in lowercase in the following pattern color-color-color-color out of #{Game::COLORS.each_with_index.map do |color, index|
          "#{index + 1}- #{color}"
        end.join(' ')}"
        guess = gets.chomp
        guess = guess.split('-')
        rating = ai.rate_guess(guess)
        if  rating.count('perfect') == 4
          player_won = true
          break
        end
      end
      puts "Perfect: #{ rating.count('perfect') }"
      puts "Exists : #{ rating.count('exists') }"
      end

      if player_won
        puts "You Won!!!"
      else
        puts "You Lost!!!"
      end

      puts 'Press R to restart or Q to quit: '
      continue = gets.chomp until ['R', 'r', 'q', 'Q'].include?(continue)

      break if ['q', 'Q'].include?(continue)
    end
  end
end


Game.update
