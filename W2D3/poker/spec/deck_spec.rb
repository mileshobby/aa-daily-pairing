require 'deck'
require 'rspec'

describe Deck do

  let(:suits) { [:hearts, :spades, :clubs, :diamonds] }
  let(:values) { (2..14).to_a }

  subject(:deck) { Deck.new }

  describe '#initialize' do
    it 'creates a deck with 52 cards' do
      expect(deck.cards.length).to eq(52)
    end

    it 'creates a deck with 4 of each value' do
      (2..14).each do |v|
        expect(deck.cards.count { |c| c.value == v }).to eq(4)
      end
    end

    it 'creates a deck with 13 of each suit' do
      suits.each do |s|
        expect(deck.cards.count { |c| c.suit == s }).to eq(13)
      end
    end

  end

  describe '#shuffle!' do
    it 'empties discard piles into cards' do
      deck.shuffle!
      expect(deck.discards).to be_empty
      expect(deck.cards.length).to eq(52)
    end

    it 'randomizes order of cards' do
      expect(deck.cards).to receive(:shuffle!)
      deck.shuffle!
    end
  end

  describe '#deal_card' do
    let(:card_top) { deck.cards.last }
    it 'pops card off of cards and returns it' do
      card_top
      expect(deck.deal_card).to be(card_top)
    end

    it 'adds popped card to discard pile' do
      card_top
      deck.deal_card
      expect(deck.discards).to include(card_top)
    end
  end
end
