require_relative 'board'
require 'colorize'

class Piece

  attr_reader :symbol, :top_team
  attr_accessor :pos, :board, :team_color

  def initialize(board, pos)
    @board = board
    @pos = pos
    @top_team = top_team?
    @team_color = top_team? ? :green : :magenta
  end

  def moves
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    dup_board = @board.dup
    dup_board.make_move!(@pos, end_pos)
    dup_board.in_check?(@team_color)
  end

  def to_s
    symbol.to_s.colorize(@team_color)
  end

  def empty?
  end

  def symbol
  end

  def top_team?
    (@pos[0] == 0) || (@pos[0] == 1)
  end

  def nil?
    false
  end

end
