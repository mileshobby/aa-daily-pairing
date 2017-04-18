require_relative 'piece'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'nullpiece'
require_relative 'queen'
require_relative 'rook'

require 'byebug'


class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new() }
    make_stating_grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def move_piece!(start_pos, end_pos)
    if self[start_pos].class == NullPiece
      raise "no piece in starting position"
    end
    unless self[start_pos].moves.include?(end_pos)
      raise "Not a valid move"
    end
    #TODO: Fix so it can only take opposite team piece & can't make any
    # => move that it wants too.
    self[end_pos], self[start_pos] = self[start_pos], NullPiece.instance
    self[end_pos].pos = end_pos
  end

  def move_piece(start_pos, end_pos)
    color = self[start_pos].team_color
    move_piece!(start_pos, end_pos)
    raise "Can't move into check" if in_check?(color)
  end

  def self.in_bounds?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def green_pieces
    @grid.flatten.select { |piece| piece.team_color == :green }
  end

  def magenta_pieces
    @grid.flatten.select { |piece| piece.team_color == :magenta }
  end

  def in_check?(color)
    king_pos = find_king(color)
    opposite_team = color == :magenta ? green_pieces : magenta_pieces
    opposite_team.any? { |piece| piece.moves.include?(king_pos) }
  end

  def checkmate?(color)
    team = color == :magenta ? magenta_pieces : green_pieces
    in_check?(color) && team.all? { |piece| piece.valid_moves.empty? }
  end

  def dup
    dup_board = Board.new
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece.class == NullPiece
          dup_board[[i, j]] = piece
        else
          dup_piece = piece.dup
          dup_piece.board = dup_board
          dup_board[[i, j]] = dup_piece
        end
      end
    end
    dup_board
  end

  protected

  def find_king(color)
    @grid.each do |row|
      row.each do |piece|
        return piece.pos if piece.is_a?(King) && piece.team_color == color
      end
    end
  end



  def make_stating_grid
    @grid.each_index do |i|
      if i == 0 || i == 7
        @grid[i] += king_row(i)
      elsif i == 1 || i == 6
        @grid[i] += pawn_row(i)
      else
        @grid[i] += null_row
      end
    end
  end

  def king_row(row_i)
    row = []
    row << Rook.new(self, [row_i, 0])
    row << Knight.new(self, [row_i, 1])
    row << Bishop.new(self, [row_i, 2])
    row << Queen.new(self, [row_i, 3])
    row << King.new(self, [row_i, 4])
    row << Bishop.new(self, [row_i, 5])
    row << Knight.new(self, [row_i, 6])
    row << Rook.new(self, [row_i, 7])
    row
  end

  def pawn_row(row_i)
    row = []
    (0..7).each do |j|
      row << Pawn.new(self, [row_i, j])
    end
    row
  end

  def null_row
    row = []
    (0..7).each do |j|
      row << NullPiece.instance
    end
    row
  end
end
