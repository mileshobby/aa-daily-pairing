class Array
  def my_uniq
    uniqs = []
    self.each do |el|
      uniqs << el unless uniqs.include?(el)
    end
    uniqs
  end

  def two_sum
    pairs = []
    (0...length + 1).each do |i|
      (i + 1...length).each do |j|
        pairs << [i, j] if self[i] + self[j] == 0
      end
    end
    pairs
  end

  def my_transpose
    raise ArgumentError.new "This is not nested" unless self[0].is_a?(Array)
    arr = Array.new(length) { Array.new }

    each do |row|
      row.each_with_index do |el, i|
        arr[i] << el
      end
    end

    arr
  end

  def stock_picker
    raise "Need at least two days" if length < 2
    prices = nil
    each_index do |i|
      (i+1...length).each do |j|
        prices = [i, j] unless prices
        prices = [i, j] if self[j]-self[i] > self[prices[1]] - self[prices[0]]
      end
    end
    prices
  end

end
