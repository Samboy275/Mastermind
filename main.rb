# frozen_string_literal: true

require './game_module'

def main
  Game.welcome_message
  Game.show_rules
  Game.show_how_to_play
  continue = ''
  loop do
    Game.game_loop
    puts 'Play Again? [y,n]'
    continue = gets.chomp until continue.match?(/Y|y|N|n/)
    break if %w[n N].include?(continue)
  end
  puts 'Thanks for playing Mastermind'
end

main
