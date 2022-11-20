# frozen_string_literal: true

# class for code breaker
class CodeBreaker
  # 1 - initialize a codebreaker object with number of tries
  # 2 - make a guess function that takes and stores the breaker guess
  attr_reader :tries, :guess, :guess, :rating, :rating

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
    @rating = []
    @solutions = colors.repeated_permutation(4).to_a
    @colors = colors
    @old_guess = []
    @old_rating = []
    @turns = 1
    super()
  end

  def make_guess()
    @old_guess = @guess
    if @guess.empty?
      @guess = [@colors[0], @colors[0], @colors[1], @colors[1]]
    elsif @turns == 2
      @guess = [@colors[1], @colors[1], @colors[0], @colors[0]]
    else
      @guess = @solutions.sample()
    end

    @turns = @turns + 1

    @guess
  end

  def check_rating(rating)
    if @rating.empty?
      @old_rating = @rating
    end
    @rating = rating
    process_guess()
  end

  private

  def process_guess()

  end
end


