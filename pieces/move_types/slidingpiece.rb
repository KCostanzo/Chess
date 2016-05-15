module SlidingPiece
  # (row, col)
  DIAGONALS = [[1,1], # down-right
              [1,-1], # up-right
              [-1,-1], # up-left
              [-1,1]] # down-left

  CARDINALS = [[0,1], # down
              [0,-1], # up
              [1,0], # right
              [-1,0]] # left

  # board accessible via @board
  # pos accessible via self.pos


  def cardinal_moves
    CARDINALS
  end

  def diagonal_moves
    DIAGONALS
  end

  def moves
    move_arr = []
    move_dirs.each do |dx,dy|
      move_arr.concat(grow_unblocked_moves_in_dir(dx,dy))
    end
    move_arr
  end

  def grow_unblocked_moves_in_dir(dx,dy)
    cur_x,cur_y = pos
    moves = []
    loop do
      cur_x, cur_y = cur_x + dx, cur_y + dy
      pos = [cur_x, cur_y]
      break unless in_bounds?(pos)
      if @board[cur_x][cur_y].empty?
        moves << pos
      else
        moves << pos if @board[cur_x][cur_y].color != self.color
        break
      end
    end
    moves
  end

  def in_bounds?(new_pos)
    x, y = new_pos
    x >= 0 && x < 8 && y >= 0 && y < 8
  end
end
