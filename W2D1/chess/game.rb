require_relative 'humanplayer'
require_relative 'board'
require_relative 'display'

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player1 = HumanPlayer.new("Miles", :magenta, @display)
    @player2 = HumanPlayer.new("Sean", :green, @display)
    @current_player = @player1
  end

  def play
    until won?(@current_player)
      switch_players!
      pos = current_player.play_turn
      @board.move_piece(pos[0], pos[1])
    end
  end

  def current_player
    @current_player
  end

  def switch_players!
    @current_player = current_player == @player1 ? @player2 : @player1
  end

  def won?(player)
    @board.checkmate?(player.color)
  end

end

x = Game.new
x.play
