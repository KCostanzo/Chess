require_relative "pieces/pawn"
require_relative "pieces/king"
require_relative "pieces/queen"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/emptytile"
require_relative "pieces/castle"
require 'byebug'

class Board
  attr_accessor :board, :pieces

  def initialize(dup_board = false)
    @board = Array.new(8) { Array.new(8) }

    place_board unless dup_board
    @pieces = pieces_and_empties
  end

  def rows
    @board
  end

  def pieces
    piece_arr = []
    @board.each do |row|
      row.each do |piece|
        piece_arr << piece unless piece.empty?
      end
    end
    piece_arr
  end

  def pieces_and_empties
    piece_arr = []
    @board.each do |row|
      row.each do |piece|
        piece_arr << piece
      end
    end
    piece_arr
  end

  def in_bounds?(new_pos)
    x, y = new_pos
    x >= 0 && x < 8 && y >= 0 && y < 8
  end

  def place_board
    place_pawns
    place_royalty
    place_back_pieces
    place_emptys
    input_piece_positions
  end

  def input_piece_positions
    @board.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        tile.pos = [i, j]
      end
    end
  end

  def place_emptys
    @board[2..5].each_with_index do |row, i|
      row.map!.with_index do |tile,j|
        tile = EmptyTile.new(@board,:blank,[i,j])
      end
    end
  end

  def place_pawns
    @board[1].map!.with_index do |tile,i|
      tile = Pawn.new(@board,:white,[1,i])
    end

    @board[6].map!.with_index do |tile,i|
      tile = Pawn.new(@board,:black,[6,i])
    end
  end

  def place_back_pieces
    @board[0][0], @board[0][-1] = Castle.new(@board,:white,[0,0]), Castle.new(@board,:white,[0,-1])
    @board[0][1], @board[0][-2] = Knight.new(@board,:white,[0,1]), Knight.new(@board,:white,[0,-2])
    @board[0][2], @board[0][-3] = Bishop.new(@board,:white,[0,2]), Bishop.new(@board,:white,[0,-3])

    @board[7][0], @board[7][-1] = Castle.new(@board,:black,[7,0]), Castle.new(@board,:black,[7,-1])
    @board[7][1], @board[7][-2] = Knight.new(@board,:black,[7,1]), Knight.new(@board,:black,[7,-2])
    @board[7][2], @board[7][-3] = Bishop.new(@board,:black,[7,2]), Bishop.new(@board,:black,[7,-3])
  end

  def place_royalty
    @board[0][3], @board[0][4] = King.new(@board,:white,[0,3]), Queen.new(@board,:white,[0,4])
    @board[7][3], @board[7][4] = King.new(@board,:black,[7,3]), Queen.new(@board,:black,[7,4])
  end

  def move(start, end_pos)
    x,y = start
    a,b = end_pos
    possible_moves = @board[x][y].moves
    piece = @board[x][y]
    possible_moves = [x,y] if possible_moves.nil?

    if possible_moves.include?(end_pos) 
      # && !move_into_check?(start, end_pos)
      @board[a][b] = piece.class.new(@board,piece.color,[a,b])
      @board[x][y] = EmptyTile.new(@board,:blank,[x,y])
    else
      puts "invalid move"
    end
  end

  def find_king(color)
    pieces.each do |piece|
      return piece if piece.is_a?(King) and piece.color == color
    end
  end

  # def in_check?(color)
  #   king_pos = find_king(color).pos

  #   pieces_and_empties.any? do |piece|
  #     piece.color != color && piece.moves.include?(king_pos)
  #   end
  # end

  # def move_into_check?(start, to_pos)
  #   test_board = self.board_dup
  #   test_board.move_piece!(start, to_pos)
  #   test_board.in_check?(color)
  # end

  def board_dup
    new_board = Board.new(true)

    pieces_and_empties.each do |piece|
      x, y = piece.pos
      new_board.board[x][y] = piece.class.new(new_board, piece.color, piece.pos)
    end
    # debugger
    new_board
  end

  def move_piece!(pos, to_pos) # allows movement into check
    x,y = pos
    a,b = to_pos

    possible_moves = @board[x][y].moves
    piece = @board[x][y]
    possible_moves = [x,y] if possible_moves.nil?

    if possible_moves.include?(to_pos)
      @board[a][b] = piece.class.new(@board,piece.color,[a,b])
      @board[x][y] = EmptyTile.new(@board,:blank,[x,y])
    else
      puts "invalid move"
    end
  end

  # def checkmate?(color)
  #   return false unless in_check?(color)

  #   my_pieces = pieces.select do |piece|
  #     piece.color == color
  #   end

  #   my_pieces.all? { |piece| piece.valid_moves.empty? }
  # end

  def valid_moves
    moves.reject! { |move| move_into_check?(move) }
  end
end
