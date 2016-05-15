require_relative 'move_types/slidingpiece'


class Queen < Piece
include SlidingPiece

  def to_s
    " ♕ "
  end

  def inspect
    puts self.moves
  end

  def move_dirs
    cardinal_moves + diagonal_moves
  end
end
