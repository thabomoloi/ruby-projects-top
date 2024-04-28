require 'json'
require 'fileutils'

# This class represents a hangman object
class Game
  def initialize
    clear_game
  end

  def select_secret_word
    words = File.readlines('google-10000-english-no-swears.txt')
    words = words.select { |word| word.strip.length.between?(5, 12) }
    @secret_word = words.sample.chomp
  end

  def start_game
    puts 'Hangman'
    puts '-------'
    if File.exist?('saved_game.json')
      print "Saved game found. Do you want to load it?(Y/N):\n>>> "
      gets.chomp.downcase == 'y' ? load_game : new_game
      puts "\n"
    else
      new_game
    end
  end

  def load_game
    saved_game = JSON.load_file('saved_game.json')
    puts 'Loading saved game...'
    @secret_word = saved_game['secret_word']
    @turns_left = saved_game['turns_left']
    @word_found = saved_game['word_found']
    @found_chars = saved_game['found_chars']
    play
  rescue Errno::ENOENT
    puts 'No saved game found. Starting a new game...'
    new_game
  end

  def new_game
    clear_game
    puts 'Starting new game...'
    select_secret_word
    play
  end

  def play
    while !@word_found && @turns_left.positive?
      puts "\nYou have #{@turns_left} guesses left."
      letter = input_letter
      save_game if letter == 'save'
      guess_secret letter
      word = current_word
      @word_found = word.none? { |chars| chars == '_' }
      puts "Word: #{word.join.upcase}"
    end
    gameover
  end

  def gameover
    puts "\n"
    if @turns_left.zero? && !@word_found
      puts 'You have run out of turns.'
    else
      puts 'Congratulations. You have guessed the secret word.'
    end
    puts "The secret word was '#{@secret_word.upcase}'."
    FileUtils.rm_f('saved_game.json')
  end

  def guess_secret(letter)
    if @found_chars.keys.include?(letter)
      puts 'You have already guessed this letter.'
    elsif @secret_word.include?(letter)
      @found_chars[letter] = true
    else
      @found_chars[letter] = false
      puts "There are no #{letter.upcase}'s in the word."
      @turns_left -= 1
    end
  end

  def input_letter
    input = ''
    loop do
      print "Guess the letter [a-Z] (or type 'save' to save and quit)):\n>>> "
      input = gets.chomp.downcase
      break if (input.match?(/\A[A-Za-z]+\z/) && input.size == 1) || input == 'save'
    end
    input
  end

  def current_word
    @secret_word.chars.map { |char| @found_chars.include?(char) ? char : '_' }
  end

  def save_game
    puts 'Saving game...'
    data = { secret_word: @secret_word, turns_left: @turns_left, word_found: @word_found, found_chars: @found_chars }
    json_string = JSON.pretty_generate(data)
    File.write('saved_game.json', json_string)
    exit 0
  end

  def clear_game
    @secret_word = ''
    @turns_left = 7
    @word_found = false
    @found_chars = {}
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.start_game
end
