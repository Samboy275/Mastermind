# frozen_string_literal: true

# class for code breaker
class CodeBreaker
  # 1 - initialize a codebreaker object with number of tries
  # 2 - make a guess function that takes and stores the breaker guess
  attr_reader :tries, :guess, :old_guess, :rating, :old_rating

  def initialize
    @guess = []
    @tries = 6
  end

  def guess=(guess)
    @guess = guess.split('-')
  end
end

class AICodeBreaker < CodeBreaker
  def initialize
    @solution = Array.new(4)
    @old_guess = []
    @old_rating = []
    @current_rating = []
    super
  end

  def make_guess(colors, _old_rating = '')
    if @guess.empty?
      puts "no old rating"
      4.times.each do |i|
        color = colors.sample
        color = colors.sample while @guess.include? color
        @guess[i] = color
      end
      @guess
    elsif !@guess.empty? && @old_guess.empty?
      puts "checking this one"
      next_guess = @guess.map do |color|
        color
      end
      2.times.each do
        next_guess.delete_at(rand(next_guess.length))
      end
      colors.each do |color|
        next_guess.append(color) if !@guess.include? color
      end
      @old_guess = @guess.map do |color|
        color
      end
      @guess = next_guess
    else
      puts "else"
      @guess = process_guess
    end

    @guess
  end

  def check_rating(rating)
    if !@current_rating.empty?
      @old_rating = @current_rating.map do |rate|
        rate
      end
    end
    @current_rating = rating
  end

  private

  def get_different_colors
    @guess + @old_guess - (@guess & @old_guess)
  end

  def process_guess
    next_guess = ['', '', '', '']

    @old_guess = @guess
    @guess = next_guess
    next_guess
  end
end



colors = %w[blue yellow red green orange purple].freeze

ai = AICodeBreaker.new
puts ai.make_guess(colors)
puts ai.make_guess(colors)
