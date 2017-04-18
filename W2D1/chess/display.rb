require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display

  attr_accessor :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    if @cursor.selected?
      render_selected
      return
    end
    system("clear")
    puts "  0 1 2 3 4 5 6 7 "
    @board.grid.each_with_index do |row, i|
      print "#{i} "
      row.each_with_index do |square, j|
        if [i, j] == @cursor.cursor_pos
          print "#{square.symbol.to_s.colorize(cursor.color).underline} "
        else
          print "#{square} "
        end
      end
      puts
    end
    nil
  end

  def render_selected
    moves = @board[@cursor.cursor_pos].moves
    system("clear")
    puts "  0 1 2 3 4 5 6 7 "
    @board.grid.each_with_index do |row, i|
      print "#{i} "
      row.each_with_index do |square, j|
        if [i, j] == @cursor.cursor_pos
          print "#{square.symbol.to_s.colorize(cursor.color).underline} "
        elsif moves.include?([i,j])
          print "#{square.symbol.to_s.colorize(:cyan).blink} "
        else
          print "#{square} "
        end
      end
      puts
    end
    nil
  end

end
#
#  x = Board.new
# y = Display.new(x)
#
# while true
#   y.render
#   y.cursor.get_input
# end
# p String.colors
