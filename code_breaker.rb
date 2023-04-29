# frozen_string_literal: true

require 'colorize'
require 'colorized_string'

class CodeBreaker
  attr_reader :guess

  def initialize(colors)
    @guess = []
    @colors = colors
  end

  def make_guess
    # takes in player input in pattern number-number-number-number
    player_input = ''
    player_input = gets.chomp until player_input.match?(/[1-6]-[1-6]-[1-6]-[1-6]/)
    player_input = player_input.split('-')
    player_input.each_with_index do |number, index|
      @guess[index] = @colors[number.to_i - 1]
    end

    @guess
  end

  def get_rating(rating)
    # takes player rating and show it to the console
    rating_string = rating.join(' ,')
    puts "[#{rating_string}]"
  end
end

class CodeBreakerAI < CodeBreaker
  def initialize(colors)
    # generates all possible combinations
    @solutions = colors.repeated_permutation(4).to_a
    super(colors)
  end

  def make_guess
    # this function should generate a guess picked up from random solutions
    # 1- first guess is picking up the top pick from the solutions
    # 2- guess is picking up a random sample from the solotuins
    @guess = if @guess.empty?
               [@colors[0], @colors[0], @colors[1], @colors[1]]
             else
               @solutions.sample
             end
    return @guess
  end

  def filter_perfects(rating)
    @guess.each_with_index do |color, index|
      next unless rating[index] == 'perfect'
      @solutions.select! do |pattern|
        is_solution = false
        is_solution = true if pattern[index] == color
        is_solution
      end

    end
  end

  def filter_exists(rating)
    @guess.each_with_index do |color, index|
      next unless rating[index] == 'exists'

      @solutions.select do |pattern|
        pattern.include?(color)
      end
    end
  end

  def clean_solutions(rating)
    @guess.each_with_index do |color, index|
      next unless rating[index] == ' '
      puts "#{rating[index]} , #{index}== ' ' is #{rating[index] == ' '}"
      @solutions.reject! do |pattern|

        puts " color to be removed #{color}"
        puts "pattern to be removed [#{pattern.each do |color|
          "#{color}"
        end.join(', ')}]"
        pattern[index] == color
      end
    end
  end

  def get_rating(rating)
    puts "solutions length before #{@solutions.length}"
    filter_perfects(rating)
    puts "solutions length after cleaning perfects #{@solutions.length}"
    filter_exists(rating)
    puts "solutions length after filtering exists #{@solutions.length}"
    clean_solutions(rating)
    puts "solutions length after filtering #{@solutions.length}"
    super(rating)
  end
end
