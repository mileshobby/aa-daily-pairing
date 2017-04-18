require_relative 'piece'
require_relative 'slidingpiece'

class Bishop < Piece
  include SlidingPiece

  def symbol
    :B
  end

end
