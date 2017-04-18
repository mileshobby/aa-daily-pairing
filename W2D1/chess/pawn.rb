require_relative 'piece'

class Pawn < Piece
  attr_reader :top_pawn, :fwd_dir

  def initialize(board, pos)
    super
    @fwd_dir = (@top_team ? [1, 0] : [-1, 0])
  end

  def symbol
    :P
  end

  def moves
    forward_steps + side_attacks
  end

  protected

  def at_start_row?
    (@top_team && @pos[0] == 1) ||
    (!@top_team && @pos[0] == 6)
  end

  def forward_dir
    @fwd_dir
  end

  def forward_steps
    dx, dy = @fwd_dir
    steps = []
    one_up = [@pos[0] + dx, @pos[1] + dy]
    return steps unless empty_spot?(one_up)
    steps << one_up
    if at_start_row?
      one_up = [one_up[0] + dx, one_up[1] + dy]
      steps << one_up if empty_spot?(one_up)
    end
    steps
  end

  def side_attacks
    right_down = [@pos[0] + 1, @pos[1] + 1]
    left_down = [@pos[0] + 1, @pos[1] - 1]
    right_up = [@pos[0] - 1, @pos[1] + 1]
    left_up = [@pos[0] - 1, @pos[1] - 1]

    steps = []
    if @top_team
      if empty_spot?(right_down)
        steps << right_down if @board[right_down].top_team == false
      elsif empty_spot?(left_down)
        steps << left_down if @board[left_down].top_team == false
      end
    else
      if empty_spot?(right_up)
        steps << right_up if @board[right_up].top_team
      elsif empty_spot?(left_up)
        steps << left_up if @board[left_up].top_team
      end
    end
    steps
  end

  def empty_spot?(pos)
    Board.in_bounds?(pos) && @board[ pos ].team_color != self.team_color
  end

end
