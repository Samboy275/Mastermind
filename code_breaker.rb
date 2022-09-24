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
      4.times.each do |i|
        color = colors.sample
        color = colors.sample while @guess.include? color
        @guess[i] = color
      end
      @guess
    elsif !@guess.empty? && @old_guess.empty?
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
      @guess = process_guess(colors)
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

  def process_guess(colors)
    next_guess = ['', '', '', '']
    if @old_rating.include?('perfect') || @current_rating.include?('perfect')
      next_guess = perfect_process(next_guess, colors)
    else
      next_guess = imprefect_process(colors)
    end
    @old_guess = @guess
    @guess = next_guess
    next_guess
  end


  def perfect_process(next_guess, colors)
    perfects = []
    chosen_guess = []
    if @current_rating.count('perfect') > @old_rating.count('perfect')
      perfects = @guess - @old_guess
      chosen_guess = @guess
    elsif @current_rating.count('perfect') < @old_rating.count('perfect')
      perfects = @old_guess - @guess
      chosen_guess = @old_guess
    else
      perfects = @guess & @old_guess
      chosen_guess = @guess
    end
    chosen_guess.each_with_index do |item, index|
      if perfects.include?(item)
        next_guess[index] = item
      end
    end
    next_guess.count('').times do
      index = next_guess.find_index('')
      color = ''
      if @old_rating.count('exsits') > @current_rating.count('exists')
         color = @old_guess.sample while next_guess.include?(color)
      else
        color = colors.sample while next_guess.include?(color)
      end
      next_guess[index] = color
      end
    next_guess
  end

  def imprefect_process(colors)
    exists = []
    if @current_rating.count('exists') == 4
      return @guess.shuffle
    end
    if @current_rating.count('exists') > @old_rating.count('exists')
      exists = @guess - @old_guess
    elsif @current_rating.count('exists') < @old_rating.count('exists')
      exists = @old_guess - @guess
    else
      exists = @guess & @old_guess
    end

    while exists.count < 4
      color = colors.sample until !(@guess & @old_guess).include?(color)
      exists.append color
    end
    exists.shuffle
  end
end


