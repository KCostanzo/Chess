require_relative 'move_types/slidingpiece'

class Bishop < Piece
include SlidingPiece

  def to_s
    #{}" ♗ "
    " ☂ "
  end

  def move_dirs
    diagonal_moves
  end
end
