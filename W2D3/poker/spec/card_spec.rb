require 'card'
require 'rspec'

describe Card do
  subject(:face_card) { Card.new(12, :clubs) }
  subject(:number_card) { Card.new(8, :hearts) }

  describe '#initialize' do

    it 'assigns a value' do
      expect(face_card.value).to eq(12)
    end

    it 'assigns a suit' do
      expect(face_card.suit).to eq(:clubs)
    end
  end

  describe '#to_s' do
    it 'outputs string that includes suit' do
      expect(face_card.to_s).to include(face_card.suit.to_s)
    end

    it 'outputs string with number correctly' do
      expect(number_card.to_s).to include("8")
    end

    it 'outputs string with face card correctly' do
      expect(face_card.to_s).to include("Q")
    end
  end
end
