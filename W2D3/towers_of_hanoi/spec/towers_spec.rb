require 'rspec'
require 'towers'

describe Towers do

  let(:size) { 3 }
  subject(:hanoi) { Towers.new(size) }

  describe '#initialize' do

    it 'sets three towers' do
      expect(hanoi.towers.length).to eq(3)
    end

    it 'sets two of them to be empty' do
      expect(hanoi.towers[1]).to be_empty
      expect(hanoi.towers[2]).to be_empty
    end

    it 'sets one to have @size disks' do
      expect(hanoi.towers[0].length).to eq(size)
    end
  end

  describe '#move' do

    it 'raises error when start tower is empty' do
      expect { hanoi.move(2, 0) }.to raise_error("No disks on that tower")
    end

    context 'when moving to empty end tower' do
      before(:each) { hanoi.move(0, 1) }
      it 'removes top disc from start tower' do
        expect(hanoi.towers[0]).to eq([3, 2])
      end
      it 'puts top disc onto end tower' do
        expect(hanoi.towers[1]).to eq([1])
      end
      it 'does not change other tower' do
        expect(hanoi.towers[2]).to be_empty
      end

    end

    context 'when end tower has disc' do
      before(:each) do
        hanoi.move(0, 1)
        hanoi.move(0, 2)
      end

      it 'moves top disc to tower with larger disc on it' do
        hanoi.move(1, 2)
        expect(hanoi.towers).to eq(
          [
            [3],
            [],
            [2, 1]
          ]
        )
      end

      it 'raises an error if end tower has smaller disc on it' do
        expect { hanoi.move(0,1) }.to raise_error("That disk is too large")
      end
    end
  end


  describe '#won?' do
    it 'does not return true when tower 0 is full' do
      expect(hanoi.won?).to be false
    end

    it 'does not return true when the disks are not on one tower' do
      hanoi.move(0, 2)

      expect(hanoi.won?).to be false
    end

    context 'when all disks are on one tower' do

      it 'returns true for tower 1' do
        hanoi.move(0, 1)
        hanoi.move(0, 2)
        hanoi.move(1, 2)
        hanoi.move(0, 1)
        hanoi.move(2, 0)
        hanoi.move(2, 1)
        hanoi.move(0, 1)

        expect(hanoi.won?).to be true
      end

      it 'returns true for tower 2' do
        hanoi.move(0, 2)
        hanoi.move(0, 1)
        hanoi.move(2, 1)
        hanoi.move(0, 2)
        hanoi.move(1, 0)
        hanoi.move(1, 2)
        hanoi.move(0, 2)

        expect(hanoi.won?).to be true
      end
    end
  end
end
