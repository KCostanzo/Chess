require_relative 'player'
require_relative 'board'
require_relative 'display'

class Game
  def initialize
    @board = Board.new
    @player = Player.new(@board)
  end

  def run
    loop do
      from_pos = @player.move_cursor
      to_pos = @player.move_cursor
      @board.move(from_pos, to_pos)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  chess = Game.new
  chess.run
end
