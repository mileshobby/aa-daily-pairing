require_relative 'piece'
require_relative 'steppablepiece'

class Knight < Piece
  include SteppablePiece

  def move_dirs
    [[1, 2], [2, 1], [1, -2], [-1, 2], [-1, -2],
    [-2, -1], [2, -1], [-2, 1]]
  end

  def symbol
    :G
  end

end
