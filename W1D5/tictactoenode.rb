require_relative 'tic_tac_toe.rb'

class TicTacToeNode
  POS_MOVES = [
    [0,0], [0,1], [0,2],
    [1,0], [1,1], [1,2],
    [2,0], [2,1], [2,2]
  ]

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def board
    @board
  end

  def children
    open_positions.map do |pos|
      next_board = board.dup
      next_board[pos] = next_mover_mark
      alt_mark = (next_mover_mark == :x ? :o : :x)
      TicTacToeNode.new(next_board, alt_mark, pos)
    end
  end

  def open_positions
    POS_MOVES.select { |pos| board.empty?(pos) }
  end

  def losing_node?(evaluator)
    this_board = evaluator.board
    if this_board.over?
      winning_mark = board.winner
    end
  end

end
