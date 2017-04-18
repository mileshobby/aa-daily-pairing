module SlidingPiece

  def moves
    possible_moves = []
    move_dirs.each do |move_dir|
      dx, dy = move_dir
      possible_moves += grow_unblocked_moves_in_dir(dx, dy)
    end
    possible_moves
  end

  private

  def move_dirs
    if self.class == Rook
      vertical_dirs + horizontal_dirs
    elsif self.class == Queen
      vertical_dirs + horizontal_dirs + diagonal_dirs
    else
      diagonal_dirs
    end
  end

  def horizontal_dirs
    [[0, 1], [0, -1]]
  end

  def vertical_dirs
    [[1, 0], [-1, 0]]
  end

  def diagonal_dirs
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    pos_moves = []
    x, y = @pos
    x, y = x + dx, y + dy
    while Board.in_bounds?([x, y]) && @board[ [x, y] ].team_color != self.team_color
      pos_moves << [x, y]
      break if @board[[x,y]].team_color != self.team_color &&
              @board[[x,y]].team_color
      x, y = x + dx, y + dy
    end
    pos_moves
  end

end
