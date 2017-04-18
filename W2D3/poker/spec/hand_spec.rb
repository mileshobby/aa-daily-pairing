require 'rspec'
require 'hand'

describe Hand do

  subject(:hand) { Hand.new }
  let(:card) { double('card') }

  describe '#initialize' do

    it 'starts hand with no cards in it' do
      expect(hand.cards).to be_empty
    end

  end

  describe '#accept_card' do
    it 'adds the card to the hand' do
      hand.accept_card(card)
      expect(hand.cards).to include(card)
    end

    it 'raises error if the hand already has 5 cards' do
      5.times do
        hand.accept_card(card)
      end
      expect { hand.accept_card(card) }.to raise_error "This hand already has 5 cards"
    end

  end

  describe '#drop_card' do

    it 'removes card at given index' do
      5.times { hand.accept_card(card) }
      hand.drop_card(0)
      expect(hand.cards.length).to eq(4)
    end

  end

  describe '#get_best_hand' do

    it 'finds a straight_flush' do
      (0..4).to_a.reverse.each { |i| hand.drop_card(i) }
      5.times do |i|
        hand.accept_card(double("card#{i+2}", :value => i+2, :suit => :hearts))
      end
      expect(hand.get_best_hand).to eq([9,6])
    end

    it 'finds a four_of_a_kind' do
      (0..4).to_a.reverse.each { |i| hand.drop_card(i) }
      4.times do |i|
        hand.accept_card(double("card#{i+2}", :value => 2, :suit => :hearts))
      end

      expect(hand.get_best_hand).to eq([8, 2])
    end

    it 'finds a full_house' do
      (0..4).to_a.reverse.each { |i| hand.drop_card(i) }
      3.times do |i|
        hand.accept_card(double("card#{i+2}", :value => 2, :suit => :hearts))
      end
      2.times do |i|
        hand.accept_card(double("card#{i+2}", :value => 3, :suit => :hearts))
      end
      expect(hand.get_best_hand).to eq([7, 2])
    end

    it 'finds a flush' do
      (0..4).to_a.reverse.each { |i| hand.drop_card(i) }
      5.times do |i|
        hand.accept_card(double("card#{i+2}", :value => i*2+2, :suit => :hearts))
      end
      expect(hand.get_best_hand).to eq([6,10])
    end

    it 'finds a straight' do
      (0..4).to_a.reverse.each { |i| hand.drop_card(i) }
      hand.accept_card(double("card#{3}", :value => 8, :suit => :spades))
      4.times do |i|
        hand.accept_card(double("card#{i}", :value => i+4, :suit => :hearts))
      end

      expect(hand.get_best_hand).to eq([5, 7])

    end

    it 'finds a three_of_a_kind' do
      (0..4).to_a.reverse.each { |i| hand.drop_card(i) }
      3.times do |i|
        hand.accept_card(double("card#{i+2}", :value => 2, :suit => :hearts))
      end
      hand.accept_card(double("card#{2}", :value => 3, :suit => :spades))

      expect(hand.get_best_hand).to eq([4, 2])
    end

    it 'finds a two_pair' do
      (0..4).to_a.reverse.each { |i| hand.drop_card(i) }
      2.times do |i|
        hand.accept_card(double("card#{i+2}", :value => 2, :suit => :hearts))
      end
      2.times do |i|
        hand.accept_card(double("card#{i+2}", :value => 3, :suit => :spades))
      end

      expect(hand.get_best_hand).to eq([3, [3,2]])
    end

    it 'finds a one_pair' do
      (0..4).to_a.reverse.each { |i| hand.drop_card(i) }
      2.times do |i|
        hand.accept_card(double("card#{i+2}", :value => 2, :suit => :hearts))
      end
      hand.accept_card(double("card#{2}", :value => 3, :suit => :spades))

      expect(hand.get_best_hand).to eq([2, 2])
    end

    it 'finds a high_card' do
      (0..4).to_a.reverse.each { |i| hand.drop_card(i) }
      hand.accept_card(double("card#{2}", :value => 3, :suit => :spades))
      3.times do |i|
        hand.accept_card(double("card#{i+2}", :value => 2+i*2, :suit => :hearts))
      end
      expect(hand.get_best_hand).to eq([1, 6])
    end
  end

end
