require_relative 'piece'

class EmptyTile < Piece

  def to_s
    "   "
  end

  def empty?
    return true
  end

  def moves
  end
end
