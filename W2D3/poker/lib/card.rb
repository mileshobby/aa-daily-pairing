class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    print_value = @value.to_s
    case print_value
    when "11"
      print_value = "J"
    when "12"
      print_value = "Q"
    when "13"
      print_value = "K"
    when "14"
      print_value = "A"
    end
    "#{print_value} of #{suit}"
  end
end
