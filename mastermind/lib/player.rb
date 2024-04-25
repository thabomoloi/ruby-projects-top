# frozen_string_literal: true

require_relative 'matches'

# This class represents a player
class Player
  def initialize
    @guess = []
    @secret_code = []
    @name = ''
  end

  attr_reader :guess, :secret_code, :name

  protected

  attr_writer :guess, :secret_code, :name
end

# This class represents  a computer player
class ComputerPlayer < Player
  def initialize
    super
    @possible_combinations = []
    self.name = 'Computer'
  end

  def generate_secret_code(length, colors)
    self.secret_code = Array.new(length) { colors.sample }
  end

  def guess_secret_code(length, colors, previous_feedback)
    if previous_feedback.none? || @possible_combinations.none?
      @possible_combinations = colors.repeated_combination(length).to_a if @possible_combinations.none?
    else
      @possible_combinations = filter_possible_combinations(previous_feedback)
    end
    self.guess = @possible_combinations.sample
  end

  def filter_possible_combinations(previous_feedback)
    @possible_combinations.select do |code|
      matches = find_matches(code, previous_feedback[:guess])
      matches[:exact_matches] == previous_feedback[:exact_matches] &&
        matches[:near_matches] == previous_feedback[:near_matches]
    end
  end
end

# Human player class
class HumanPlayer < Player
  def initialize
    super
    self.name = 'Human'
  end

  def generate_secret_code(length, colors)
    message = "Enter secret code (#{colors.join(' ')}):"
    print "#{message}\nEnter #{length} colors separated by spaces:\n>> "
    code = gets.chomp.split
    while code.length != length
      print "\n#{message}\nEnter exactly #{length} colors separated by spaces:\n>> "
      code = gets.chomp.split
    end
    puts "\n"
    self.secret_code = code
  end

  def guess_secret_code(length, colors)
    message = "Guess the secret colors (#{colors.join(' ')}):"
    print "#{message}\nEnter #{length} colors separated by spaces:\n>> "
    input = gets.chomp.split
    while input.length != length
      print "\n#{message}\nPlease enter exactly #{length} colors separated by spaces:\n>> "
      input = gets.chomp.split
    end
    puts "\n"
    self.guess = input
  end
end
