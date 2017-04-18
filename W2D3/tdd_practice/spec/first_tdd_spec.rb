require 'first_tdd'
require 'rspec'

describe Array do
  describe '#my_uniq' do

    it 'returns an empty array if given an empty array' do
      expect([].my_uniq).to eq([])
    end

    it 'removes a single duplicate copy' do
      expect([1,2,2,3].my_uniq).to eq([1,2,3])
    end

    it 'removes all duplicates' do
      expect([1,2,2,2,3,3].my_uniq).to eq([1,2,3])
    end
  end

  describe '#two_sum' do

    it 'returns an empty array if no pairs sum to zero' do
      expect([1, 2].two_sum).to eq([])
    end

    it 'returns the pair of indices if they sum to zero' do
      expect([2, 1, -2].two_sum).to eq([[0, 2]])
    end

    it 'returns multiple pairs' do
      expect([2, 1, -2, -2].two_sum).to eq([[0, 2], [0, 3]])
    end

    it 'each index in a pair is unique' do
      expect([0, 1, 2].two_sum).to eq([])
    end
  end

  describe '#my_transpose' do

    subject(:array) {
      [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]
    }

    it 'raise an error if no nested arrays' do
      expect { [0,1,2].my_transpose }.to raise_error(ArgumentError)
    end

    it 'makes the rows the columns' do
      expect(array.my_transpose).to eq(
        [
            [1, 4, 7],
            [2, 5, 8],
            [3, 6, 9]
        ]
      )
    end

    it 'switches the length or rows and columns' do
      expect(array.my_transpose.length).to eq(3)
      expect(array.my_transpose[0].length).to eq(3)
    end
  end

  describe '#stock_picker' do

    let(:simple_prices) {[1,2,4,5]}
    let(:large_drop) {[8,1,2]}

    it 'raises an error if length is less than 2' do
      expect{[1].stock_picker}.to raise_error("Need at least two days")
    end

    it 'returns an array of size two' do
      expect(simple_prices.stock_picker.length).to eq(2)
    end

    it 'returns two indices with biggest positive increase' do
      expect(simple_prices.stock_picker).to eq([0, 3])
    end

    it 'doesn\'t sell before buying' do
      expect(large_drop.stock_picker).to eq([1, 2])
    end

    it 'returns smallest deficit if no positive jumps' do
      expect([5, 3, 2].stock_picker).to eq([1, 2])
    end
  end
end
