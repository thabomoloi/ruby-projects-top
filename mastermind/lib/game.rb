# frozen_string_literal: true

# Game clas
class Game
  COLORS = %w[Red Green Blue Yellow Orange Purple].freeze
  MAX_TURNS = 12
  def initialize
    @turns = MAX_TURNS
  end
end
