require_relative 'board'

class Minesweeper
  def initialize(board = Board.new(10))
    @board = board
  end

  def play
    puts "Welcome to Minesweeper"
    lose = false

    until lose
      system("clear")
      @board.render
      pos = get_pos
      if get_flag == "f"
        @board.place_flag(pos)
      else
        lose = @board.reveal(pos) unless @board[pos].flagged
        break if @board.won?
      end
    end
    system("clear")
    @board.render_all
    puts (lose ? "You lose" : "You win!")
  end

  def get_pos
    print "Enter your position (x,y): "
    gets.chomp.split(",").map(&:to_i)
  end

  def get_flag
    print "Enter f to flag or anything else to reveal: "
    gets.chomp
  end

end

if __FILE__ == $PROGRAM_NAME
  print "Enter number of bombs desired: "
  difficulty = gets.chomp.to_i
  board = Board.new(difficulty)

  game = Minesweeper.new(board)
  game.play
end
