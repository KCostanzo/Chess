require_relative '../piece'

module SteppingPiece
  # board accessible via @board
  # pos accessible via @pos
  def moves
    possible_stepping_moves
  end

  def possible_stepping_moves
    cur_x, cur_y = pos

    moves = []
    move_diffs.each do |dx, dy|
      new_pos = [dx + cur_x, dy + cur_y]
      moves << new_pos if in_bounds?(new_pos) unless moves.include?(new_pos)
    end

    selected = moves.select do |x, y|
      @board[x][y].color != color
    end
    
    selected
  end

  def in_bounds?(new_pos)
    x, y = new_pos
    x >= 0 && x < 8 && y >= 0 && y < 8
  end
end
