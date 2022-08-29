# frozen_string_literal: true

# class for code breaker
class CodeBreaker
  # 1 - initialize a codebreaker object with number of tries
  # 2 - make a guess function that takes and stores the breaker guess
  attr_reader :tries, :guess

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
    @old_guess = ''
    @old_rating = ''
    @current_rating = ''
    @guess = ''
    super
  end

  def make_guess(colors, _old_rating = '')
    if @old_rating == ''
      puts "no old rating"
      4.times.each do |i|
        color = colors.sample
        color = colors.sample while @guess.include? color
        @guess[i] = color
      end
      @old_guess = @guess
      @guess
    else
      @guess = process_guess
    end

    @guess
  end

  def check_rating(rating)
    @old_rating = if @old_rating == ''
                    rating
                  else
                    @current_rating
                  end
    @current_rating = rating
  end

  private

  def get_different_colors
    @guess + @old_guess - (@guess & @old_guess)
  end

  def process_guess

  end
end
