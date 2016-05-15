require_relative 'move_types/steppingpiece'

class Knight < Piece
  include SteppingPiece

  def to_s
    " ♘ "
  end

  KNIGHT_MOVES = [[2,1],
                  [1,2],
                  [-2,1],
                  [1,-2],
                  [-1,2],
                  [-1,-2],
                  [2,-1],
                  [-2,-1]]

  def move_diffs
    KNIGHT_MOVES
  end
end
