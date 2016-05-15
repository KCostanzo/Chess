require_relative "piece"
require 'byebug'

class Pawn < Piece
  WHITE_PAWN_MOVES = [[1,0]]
  WHITE_FIRST_MOVES = [[1,0],[2,0]]
  BLACK_FIRST_MOVES = [[-1,0],[-2,0]]
  BLACK_PAWN_MOVES = [[-1,0]]

  def in_bounds?(new_pos)
    return false if new_pos.nil?
    x, y = new_pos
    x >= 0 && x < 8 && y >= 0 && y < 8
  end

  def moves
    possible_pawn_moves
  end

  def takable_enemy?
    !enemy_spots.empty?
  end

  def enemy_spots
    x,y = pos
    enemy_pos = []
    if color == :black
      if in_bounds?([x-1,y-1])
        enemy_pos << [x-1,y-1] if @board[x-1][y-1].color == :white
      end
      if in_bounds?([x-1,y+1])
        enemy_pos << [x-1,y+1] if @board[x-1][y+1].color == :white
      end
    elsif color == :white
      if in_bounds?([x+1,y+1])
        enemy_pos << [x+1,y+1] if @board[x+1][y+1].color == :black
      end
      if in_bounds?([x+1,y-1])
        enemy_pos << [x+1,y-1] if @board[x+1][y-1].color == :black
      end
    end
    enemy_pos
  end

  def move_diffs
    (self.color == :white) ? white_move_diffs : black_move_diffs
  end

  def white_move_diffs
    moves = []
    x,y = pos
    if x == 1
      moves += WHITE_FIRST_MOVES unless enemy_in_front?
    else
      moves += WHITE_PAWN_MOVES unless enemy_in_front?
    end
    moves
  end

  def enemy_in_front?
    x,y = pos
    if color == :white
      return true if @board[x+1][y].color == :black
    elsif color == :black
      return true if @board[x-1][y].color == :white
    end
    false
  end

  def black_move_diffs
    moves = []
    x,y = pos
        #  debugger
    if x == 6
      moves += BLACK_FIRST_MOVES unless enemy_in_front?
    else
      moves += BLACK_PAWN_MOVES unless enemy_in_front?
    end
    moves
  end

  def possible_pawn_moves
    cur_x, cur_y = pos

    moves = []
    move_diffs.each do |dx, dy|
      new_pos = [dx + cur_x, dy + cur_y]
      moves << new_pos if in_bounds?(new_pos) unless moves.include?(new_pos)
    end

    # selected = moves.select do |x, y|
    #   @board[x][y].color != color
    # end

    moves += enemy_spots
  end


  def to_s
    #{}" ♙ "
    " 💩 "
  end
end
