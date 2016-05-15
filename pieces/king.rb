require_relative 'move_types/steppingpiece'


class King < Piece
  include SteppingPiece

  def to_s
    " ♔ "
  end

  KING_MOVES = [[1,1], # down-right
              [1,-1], # up-right
              [-1,-1], # up-left
              [-1,1], # down-left
              [0,1], # down
              [0,-1], # up
              [1,0], # right
              [-1,0]] # left

  def move_diffs
    KING_MOVES
  end
end
