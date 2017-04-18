require_relative 'piece'
require_relative 'slidingpiece'

class Queen < Piece
  include SlidingPiece

  def symbol
    :Q
  end

end
