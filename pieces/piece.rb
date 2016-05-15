class Piece
  attr_accessor :pos
  attr_reader :color

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
  end

  def moves
    []
  end

  def to_s
    '   '
  end

  def empty?
    false
  end

  

end
