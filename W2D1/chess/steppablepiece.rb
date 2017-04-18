module SteppablePiece

  def moves
    move_diffs(self.move_dirs)
  end

  private

  def move_diffs(move_dirs)
    pos_moves = []
    move_dirs.each do |move_dir|
      x, y = @pos
      x += move_dir[0]
      y += move_dir[1]
      if Board.in_bounds?([x, y]) && @board[ [x, y] ].team_color != self.team_color
        pos_moves << [x, y]
      end
    end
    pos_moves
  end



end
