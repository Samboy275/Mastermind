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

      if rating[:perfect] > 0 || rating[:exists] > 0
        @solutions.filter! do |pattern|
          pattern.include?(@colors[0]) || pattern.include?(@colors[1])
        end
        if rating[:exists] == 2
          @solutions.filter! do |pattern|
           pattern[0] != @colors[0] && pattern[1] != @colors[0] && pattern[2] != @colors[1] && pattern[3] != @colors[1]
          end
        elsif rating[:perfect] > 0
          @solutions.filter! do |pattern|
            pattern[0] == @colors[0] || pattern[1] == @colors[0] || pattern[2] == @colors[1] || pattern[3] == @colors[1]
          end

        end
      end
    end
    @rating = rating
  end

  private

  def process_guess()

  end

  def check_for_perfects()
    if @rating[:perfect] > 0
      @solutions.filter! do |pattern|
        possible_solution = false
        pattern.each_with_index do |color, index|
          if color == @guess[index]
            possible_solution = true
            break
          end
        end
        possible_solution
      end
    else
      @solutions.filter! do |pattern|
        possible_solution = false
        pattern.each_with_index do |color, index|
          if color != @guess[index]
            possible_solution = true
            break
          end
        end
        possible_solution
      end
    end
  end


  def check_for_exsits()
    if @rating[:exists] > 0
      @solutions.filter! do |pattern|
        possible_solution = false
        @guess.each do |color|
          if pattern.include?(color)
            possible_solution = true
            break
          end
        end
        possible_solution
      end
    elsif @rating[:perfect] == 0
      @solutions.filter! do |pattern|
        possible_solution = true
        @guess.each do |color|
          if pattern.include?(color)
            possible_solution = false
            break
          end
        end
        possible_solution
      end
    end
  end
end


