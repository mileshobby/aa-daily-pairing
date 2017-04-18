require_relative 'piece'
require_relative 'slidingpiece'

class Rook < Piece
  include SlidingPiece

  def symbol
    :R
  end

end
