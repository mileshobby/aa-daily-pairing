class Hand
  attr_reader :cards

  HAND_VALUES = {
    straight_flush: 9,
    four_of_a_kind: 8,
    full_house: 7,
    flush: 6,
    straight: 5,
    three_of_a_kind: 4,
    two_pair: 3,
    one_pair: 2,
    high_card: 1
    }

  def initialize
    @cards = []
  end

  def accept_card(card)
    raise "This hand already has 5 cards" if @cards.length == 5

    @cards << card
  end

  def drop_card(idx)
    @cards.delete_at(idx)
  end

  def get_best_hand
    return straight_flush if straight_flush
    return four_of_a_kind if four_of_a_kind
    return full_house if full_house
    return flush if flush
    return straight if straight
    return three_of_a_kind if three_of_a_kind
    return two_pair if two_pair
    return one_pair if one_pair
    return high_card
  end

  private

  def hash_by_values
    values = Hash.new(0)
    @cards.each do |card|
      values[card.value]+=1
    end
    values
  end

  def same_suit?
    @cards.map(&:suit).uniq.length == 1
  end

  def in_straight?
    values = @cards.map(&:value).sort
    values.each_index do |i|
      next if i + 1 == values.length
      return false unless values[i+1] - values[i] == 1
    end

    true
  end

  def of_a_kind(n, first = nil)
    hash_by_values.each do |k,v|
      return k if v == n && k != first
    end
    nil
  end

  def straight_flush
    in_straight? && same_suit? ? [HAND_VALUES[:straight_flush], @cards.max(&:value).value] : nil
  end

  def four_of_a_kind
    four = of_a_kind(4)
    four ? [HAND_VALUES[:four_of_a_kind], four] : nil
  end

  def full_house
    three = of_a_kind(3)
    two = of_a_kind(2, three)
    three && two ? [HAND_VALUES[:full_house], three] : nil
  end

  def flush
    same_suit? ? [HAND_VALUES[:flush], @cards.max(&:value).value] : nil
  end

  def straight
    in_straight? ? [HAND_VALUES[:straight], @cards.max(&:value).value] : nil
  end

  def three_of_a_kind
    three = of_a_kind(3)
    three ? [HAND_VALUES[:three_of_a_kind], three] : nil
  end

  def two_pair
    first = of_a_kind(2)
    second = of_a_kind(2, first)
    second && first ? [HAND_VALUES[:two_pair], [first, second].sort.reverse] : nil
  end

  def one_pair
    two = of_a_kind(2)
    two ? [HAND_VALUES[:one_pair], two] : nil
  end

  def high_card
    [HAND_VALUES[:high_card], @cards.max(&:value).value]
  end

end
