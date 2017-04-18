require_relative 'cursor'

class HumanPlayer
  attr_reader :name, :color, :display

  def initialize(name, color, display)
    @name = name
    @color = color
    @display = display
  end

  def play_turn
    @display.render
    puts "Please select a piece to move"
    pos1 = @display.cursor.get_input
    until pos1
      @display.render
      puts "Please select a piece to move"
      pos1 = @display.cursor.get_input
    end
    @display.render
    puts "Select a place to move to "
    pos2 = @display.cursor.get_input
    until pos2
      puts "Select a place to move to "
      @display.render
      pos2 = @display.cursor.get_input
    end
    [pos1, pos2]
  end
end
