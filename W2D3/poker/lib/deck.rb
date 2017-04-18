require_relative 'card'

class Deck
  attr_reader :cards, :discards

  SUITS = [:hearts, :clubs, :spades, :diamonds]
  VALUES = (2..14).to_a

  def initialize
    @cards = []
    VALUES.each do |v|
      SUITS.each do |s|
        @cards << Card.new(v, s)
      end
    end
    @discards = []
  end

  def shuffle!
    @cards.concat(@discards)
    @discards = []
    @cards.shuffle!
  end

  def deal_card
    card = @cards.pop
    discards << card
    card
  end

end
