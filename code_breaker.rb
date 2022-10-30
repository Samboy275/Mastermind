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

  def make_guess(_rating = '')
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
    @old_rating = @rating if !@rating.empty?
    @rating = rating
    if @rating[:perfect] > 0
      length_before = @solutions.length
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
      if @solutions.length == length_before
        perfects = []
        if @old_rating[:perfect] > @rating[:perfect]
          perfects = @old_guess - @guess
        elsif @old_rating[:perfect] < @old_rating[:perfect]
          perfects = @guess - @old_guess
        else
          perfects = @old_guess & @guess
        end

        @solutions.filter! do |pattern|
          possible_solution = false
          pattern.each_with_index do |color, index|
            if perfects.include?(color)
              if color == @guess[index]
                possible_solution = true
              end
            end
          end
          possible_solution
        end
      end
    elsif @rating[:exists] > 0
      @solutions.filter! do |pattern|
        possible_solution = false
        @guess.each_with_index do |color, index|
          if pattern.include?(color) && @guess[index] != pattern[index]
            possible_solution = true
            break
          end
        end
        possible_solution
      end
    else
      @solutions.filter! do |pattern|
        possible_solution = true
        @guess.each do |color|
          if pattern.include?(color)
            possible_solution = false
          end
        end
        possible_solution
      end
    end
    puts @solutions.length
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


