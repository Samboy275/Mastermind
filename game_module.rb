# frozen_string_literal: true

require 'colorize'
require 'colorized_string'
require './code_maker'
require './code_breaker'

module Game
  TURNS = 12
  COLORS = %i[blue green yellow cyan red white].map do |color|
    ColorizedString.new(color.to_s).colorize(color)
  end

  HOW_TO_PLAY = ['pick your role code make or code breaker',
                 'as code maker make a code by selecting 4 of the availabe colors',
                 'as code breaker try to guess the computer color code by inputting a four color pattern'].freeze

  RULES = ['one game has 12 rounds',
           'you can exit at the end of any round',
           'if the code breaker guesses the code before the end of the 12
           rounds they win else the code maker wins'].freeze

  def self.show_rules
    # printing game rules for player
    puts 'Game RULES: '

    RULES.each_with_index do |text, index|
      puts "#{index + 1} - #{text}"
    end
  end

  def self.show_how_to_play
    # printing how to play for player
    puts 'how to play: '

    HOW_TO_PLAY.each_with_index do |text, index|
      puts "#{index + 1} - #{text}"
    end
  end

  def self.welcome_message
    message = '*********Welcome To Mastermind********'.black.on_yellow
    puts message
  end

  def self.player_choice_input
    print 'Enter 1 to play as code breaker or 2 to play as code maker: '
    player_choice = ''
    player_choice = gets.chomp until player_choice.match?(/[1-2]/)
    player_choice.to_i
  end

  def self.color_view_message
    # shows the color with thier numbers to the player
    print 'Guess a 4 color code from the following colors using thier'
    puts 'numbers in this pattern number-number-number-number:'

    COLORS.each_with_index do |color, index|
      puts "#{index + 1} - #{color}"
    end
  end

  def self.color_code_message
    # shows the color with thier numbers to the player
    puts 'make a 4 color code from the following colors using thier numbers:'

    COLORS.each_with_index do |color, index|
      puts "#{index + 1} - #{color}"
    end
  end

  def self.player_code
    code = ['', '', '', '']
    player_input = ''

    (1..4).each do |i|
      print "Color Number #{i}: "
      player_input = gets.chomp until player_input.match?(/[1-6]/)
      code[i - 1] = COLORS[player_input.to_i - 1]
      player_input = ''
    end

    code
  end

  def self.game_loop
    # main game loop in which the game play happens

    # take player input to play as breaker or maker

    player_choice = player_choice_input
    code_maker = ''
    code_breaker = ''
    # set player based on choice
    #
    if player_choice == 1
      code_maker = CodeMaker.new(COLORS)
      code_breaker = CodeBreaker.new(COLORS)
      # puts code_maker.code
    else
      # instantiate a code maker for the player

      color_code_message
      code = player_code
      code_maker = CodeMaker.new(code)
      code_breaker = CodeBreakerAI.new(COLORS)
      # puts code_maker.code

    end
    puts code_maker
    puts code_breaker
    TURNS.times do
      # take guess

      color_view_message
      guess = code_breaker.make_guess
      puts "the guess is #{guess.each do |color|
        "#{color}}"
      end.join(' - ')}"
      rating = code_maker.rate_guess(guess)
      code_breaker.get_rating(rating)
      next unless rating.count('perfect') == 4

      if player_choice == 1
        puts 'Congratzz you guessed the right code and won'
      else
        puts 'The computer was able to guess your code better luck next time'
      end
      return
    end
    if player_choice == 2
      puts 'You won the computer wasnt able to guess your code'
    else
      puts 'You lost you werent able to guess the correct code'
    end
  end
end
