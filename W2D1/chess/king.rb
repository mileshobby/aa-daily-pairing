require_relative 'piece'
require_relative 'steppablepiece'

class King < Piece
  include SteppablePiece

  def move_dirs
    [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1],
    [-1, -1], [1, -1], [-1, 1]]
  end

  def symbol
    :K
  end

end
