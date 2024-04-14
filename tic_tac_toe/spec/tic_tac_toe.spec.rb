require 'spec_helper'
require_relative '../lib/tic_tac_toe'

describe Player do
  let(:board) { Board.new }
  subject(:player) { described_class.new(board, 'X') }

  describe '#make_move' do
    it 'makes a move on the board' do
      player.make_move(0)
      expect(board.board[0]).to eq('X')
    end
  end
end

describe Board do
  subject(:board) { described_class.new }

  describe '#valid_move?' do
    it 'returns true for a valid move' do
      expect(board.valid_move?(0)).to be true
    end

    it 'returns false for an invalid move' do
      board.make_move(0, 'X')
      expect(board.valid_move?(0)).to be false
    end
  end

  describe '#full?' do
    it 'returns false when the board is not full' do
      expect(board.full?).to be false
    end

    it 'returns true when the board is full' do
      board.instance_variable_set(:@board, ['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'])
      expect(board.full?).to be true
    end
  end
end

describe Game do
  subject(:game) { described_class.new }

  describe '#game_over?' do
    it 'returns false when the game is not over' do
      expect(game.game_over?).to be false
    end

    it 'returns true when the game is over' do
      game.instance_variable_get(:@board).instance_variable_set(:@board, ['X', 'X', 'X', 'O', 'O', 'X', 'O', 'X', 'O'])
      expect(game.game_over?).to be true
    end
  end

  describe '#winner?' do
    it 'returns true when there is a winner' do
      game.instance_variable_get(:@board).instance_variable_set(:@board, ['X', 'X', 'X', 'O', 'O', ' ', ' ', ' ', ' '])
      expect(game.winner?('X')).to be true
    end

    it 'returns false when there is no winner' do
      game.instance_variable_get(:@board).instance_variable_set(:@board, ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X'])
      expect(game.winner?('X')).to be false
    end
  end
end
