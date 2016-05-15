require "colorize"
require_relative "cursorable"
require_relative "board"

class Display
  include Cursorable
  attr_accessor :cursor_pos, :chosen_pos

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @chosen_pos = @cursor_pos
  end

  # def render
  #   @board.each_with_index do |row, i|
  #     row_str = "|"
  #     row.each_with_index do |tile, j|
  #       row_str << "#{tile.to_s}|"
  #     end
  #     puts row_str
  #   end
  #   puts
  # end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :blue
    elsif (i + j).odd?
      bg = :dark_blue
    else
      bg = :light_blue
    end
    { background: bg, color: :white }
  end

  def render
    system("clear")
    puts "Arrow keys, space to choose a piece."
    build_grid.each { |row| puts row.join }
  end

end
#
# display = Display.new(Board.new)
# p display.render
