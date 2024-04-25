# frozen_string_literal: true

require_relative 'player'
require_relative 'matches'

# Class for the Mastermind game
class Mastermind
  COLORS = %w[Red Green Blue Yellow Orange Purple].freeze
  MAX_TURNS = 12
  CODE_LENGTH = 4

  def initialize
    @turns_left = MAX_TURNS
    @game_over = false
    @mode = 1
    @code_creator = nil
    @code_guesser = nil
    @previous_feedback = {}
  end

  def generate_secret_code
    puts "Choose:\n1. Create a secret code\n2. Guess a secret code"
    print 'Option (1 or 2): '
    @mode = gets.chomp.to_i
    puts ''
    @code_creator = @mode == 1 ? HumanPlayer.new : ComputerPlayer.new
    @code_guesser = @mode == 2 ? HumanPlayer.new : ComputerPlayer.new
    @code_creator.generate_secret_code(CODE_LENGTH, COLORS)
  end

  def guess_secret_code
    if @mode == 1
      @code_guesser.guess_secret_code(CODE_LENGTH, COLORS, @previous_feedback)
    else
      @code_guesser.guess_secret_code(CODE_LENGTH, COLORS)
    end
  end

  def check_guess(guess)
    matches = find_matches(@code_creator.secret_code, guess)
    @previous_feedback = { guess: guess }.merge(matches)
    puts "ROUND #{Mastermind::MAX_TURNS - @turns_leftc}"
    puts "#{@code_guesser.name == 'Human' ? 'Your' : "Computer's"} guess: #{guess}"
    puts "Feedback: #{matches[:exact_matches]} exact match(es), #{matches[:near_matches]} near match(es)\n\n"
    matches.values
  end

  def secret_code_guessed?(exact_matches)
    if exact_matches == Mastermind::CODE_LENGTH
      winner = @code_guesser.name
      puts "#{winner == 'Computer' ? winner : 'Congratulations! You'} guessed the secret code!"
      return true
    end
    false
  end

  def out_of_turns?
    if @turns_left.zero?
      puts "Out of turns! The secret code was: #{@code_creator.secret_code}"
      return true
    end
    false
  end

  def game_over?(feedback)
    secret_code_guessed?(feedback[0]) || out_of_turns?
  end

  def play
    puts 'WELCOME TO MASTERMIND!'
    puts '----------------------'
    generate_secret_code
    game_over = false
    until game_over
      @turns_left -= 1
      guess = guess_secret_code
      feedback = check_guess guess
      game_over = game_over?(feedback)
    end
  end
end

Mastermind.new.play
