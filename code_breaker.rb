
# class for code breaker
class CodeBreaker
  # 1 - initialize a codebreaker object with number of tries
  # 2 - make a guess function that takes and stores the breaker guess
  attr_reader :tries, :guess

  def initialize
    @guess = ''
    @tries = 6
  end

  def guess=(guess)
    @guess = guess.split('-')
  end
end


class AICodeBreaker

end
