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
  def initialize(colors)
    @solution = Array.new(4)
    @old_guess = []
    @old_rating = []
    @current_rating = []
    @solutions = colors.permuatations(4).to_a
    @colors = colors
    super
  end

  def make_guess(_old_rating = '')
    if @guess.empty?
      @guess = [@colors[0], @colors[0], @colors[1], @colors[1]]
    elsif @old_guess.empty?
      @guess = [@colors[10], @colors[1], @colors[0], @colord[0]]
    else
      #process another guess
    end
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

  def process_guess(colors)

  end
end


