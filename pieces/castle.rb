require_relative 'move_types/slidingpiece'


class Castle < Piece
include SlidingPiece

  def to_s
    " ♖ "
  end

  def move_dirs
    cardinal_moves
  end
end
