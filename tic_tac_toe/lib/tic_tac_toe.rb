class Player
  attr_reader :shape

  def initialize(board, shape)
    @board = board
    @shape = shape
  end

  def make_move(move)
    @board.make_move(move, @shape)
  end
end

class Board
  attr_reader :board

  def initialize
    @board = Array.new(9, ' ')
  end

  def valid_move?(move)
    (0..8).include?(move) && @board[move] == ' '
  end

  def make_move(move, shape)
    @board[move] = shape if valid_move?(move)
  end

  def full?
    @board.none? { |shape| shape == ' ' }
  end

  def clear
    @board.fill(' ')
  end
end

class Game
  attr_reader :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new(@board, 'X')
    @player2 = Player.new(@board, 'O')
  end

  def game_over?
    winner = self.winner?('X') ? 'X' : (self.winner?('O') ? 'O' : ' ')
    if winner != ' ' || @board.full?
      true
    else
      false
    end
  end

  def winner?(shape)
    win_patterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
    win_patterns.any? do |pattern|
      pattern.all? { |index| @board.board[index] == shape }
    end
  end

  def print_result
    winner = self.winner?('X') ? 'X' : (self.winner?('O') ? 'O' : ' ')
    puts winner != ' ' ? "Game over! #{winner} wins." : 'Game over! Tie.'
  end

  def print_board
    board = @board.board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "---+---+---"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "---+---+---"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def start
    print_board
    turn = player1.shape
    until game_over?
      puts "Player #{turn}'s turn. Enter move (0-8): "
      move = gets.chomp.to_i
      if @board.valid_move?(move)
        @board.make_move(move, turn)
        print_board
        turn = (turn == player1.shape) ? player2.shape : player1.shape
      else
        puts "Invalid move. Try again."
      end
    end
    print_result
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.start
end
