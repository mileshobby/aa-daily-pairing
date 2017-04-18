require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
    @top_team = nil
  end

  def moves
    []
  end

  def symbol
    :-
  end

  def to_s
    "-"
  end

  def nil?
    true
  end

end
