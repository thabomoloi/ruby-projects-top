# frozen_string_literal: true

# This class represents a Matcher for a Mastermind game, which calculates
# the number of exact matches and near matches between a secret code and a guess.
class Matcher
  # Initializes a new Matcher instance with the given secret code and guess.
  def initialize(secret_code, guess)
    @secret_code = secret_code
    @guess = guess
    @exact_matches = secret_code.zip(guess).count { |secret_color, guess_color| secret_color == guess_color }
    @near_matches = 0
    @secret_colors_remaining = secret_code.dup
    @guess_colors_remaining = guess.dup
  end

  # Removes exact matches from the remaining colors arrays.
  def remove_exact_matches
    @secret_colors_remaining.delete_if.with_index do |secret_color, index|
      if @guess_colors_remaining[index] == secret_color
        @guess_colors_remaining[index] = nil
        true
      else
        false
      end
    end
  end

  # Counts the number of near matches between the remaining colors arrays.
  def count_near_matches
    @guess_colors_remaining.compact.each do |guess_color|
      find_matches
      if @secret_colors_remaining.include?(guess_color)
        @near_matches += 1
        @secret_colors_remaining.delete_at(@secret_colors_remaining.index(guess_color))
      end
    end
  end

  # Finds the exact and near matches between the secret code and the guess.
  def find_matches
    remove_exact_matches
    count_near_matches
    { exact_matches: @exact_matches, near_matches: @near_matches }
  end
end

# Finds the matches between a secret code and a guess using the Matcher class.
def find_matches(secret_code, guess)
  Matcher.new(secret_code, guess).find_matches
end
