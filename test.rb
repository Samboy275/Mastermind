
def filter_perfects(guess, solutions)
  puts 'perfects'
  length_before = solutions.length
  solutions.filter! do |pattern|
    possible_solution = false
    pattern.each_with_index do |color, index|
      if color == guess[index]
        possible_solution = true
        break
      end
    end
    possible_solution
  end
end


def filter_exists(guess, solutions, rating)
  puts 'exists'
  if rating[:perfect] > 0 || rating[:exists] > 0
   solutions.filter! do |pattern|
    possible_solution = false
        guess.each_with_index do |color, index|
          if pattern.include?(color)
            possible_solution = true
            break
          end
        end
    possible_solution
   end
  elsif rating[:perfect] == 0
    solutions.filter! do |pattern|
      possible_solution = true
      guess.each_with_index do |color, index|
        if pattern.include?(color)
          possible_solution = false
          break
        end
      end
    end
  end
end

def rate_guess(guess, code)
  rating = { perfect: 0, exists: 0}
  rated = {code[0] => false, code[1] => false, code[2] => false, code[3] => false}
  code.each_with_index do |color, index|
    if color == guess[index]
      rating[:perfect] += 1
    elsif code.include? guess[index] && !rated[color]
      rating[:exists] += 1
      rated[color] = true
    end
  end
  rating
end

COLORS = %w[blue yellow red green orange purple].freeze

solutions = COLORS.repeated_permutation(4).to_a

code = [COLORS[0], COLORS[1], COLORS[2], COLORS[4]]


turns = 12

guess = [COLORS[0], COLORS[0], COLORS[1], COLORS[1]]

rating = rate_guess(guess, code)


puts rating


turns.times do |index|
  rating[:perfect] = 0
  rating[:exists] = 0
  puts solutions.length
  if index == 0
    guess = [COLORS[0], COLORS[0], COLORS[1], COLORS[1]]
    rating = rate_guess(guess, code)
    filter_perfects(guess, solutions) if rating[:perfect] > 0
    filter_exists(guess, solutions, rating)
  elsif index == 1
    guess = [COLORS[1], COLORS[1], COLORS[0], COLORS[0]]
    rating = rate_guess(guess, code)
    filter_perfects(guess, solutions) if rating[:perfect] > 0
    filter_exists(guess, solutions, rating)
  else
    guess = solutions.sample
    rating = rate_guess(guess, code)
    filter_perfects(guess, solutions) if rating[:perfect] > 0
    filter_exists(guess, solutions, rating)
  end
  puts rating
  break if rating[:perfect] == 4
end

puts guess
