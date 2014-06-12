load 'piece.rb'
require 'debugger'

class Board
	attr_accessor :pos, :board
	attr_reader :rows
	
	def initialize(create_new = true)
		@rows = Array.new(8) { Array.new(8) }
		populate_checkers if create_new
	end
	
	def empty?(pos)
		return nil unless @board[pos[0]][pos[1]]
	end
	
	def populate_checkers
		[:RED, :BLACK].each do |color|
			fill(color)
		end
	end
	
	def fill(color)
		@rows.each_with_index do |row, row_idx|
			row.each_with_index do |square, col_idx|
				next unless (row_idx + col_idx) % 2 == 0
				next if color == :BLACK && row_idx > 2
				next if color == :RED && row_idx < 5
				row[col_idx] = Piece.new(self, color, [row_idx, col_idx])
			end
		end
	end
	
  def add_piece(piece, pos)
    check_pos = @rows[pos[0]][pos[1]]
		 check_pos = piece unless check_pos
   end

	
	def draw
		@rows.map do |row|
			row.map do |square|
				square.nil? ? "." : square.to_s
			end.join(" ")
		end.join("\n")
	end

	def pieces_list
		@rows.flatten.compact
	end 
	
	def dup
		dup_board = Board.new(false)
		pieces_list.each do |piece|
			loc = piece.pos
			color = piece.color
			dup_board.rows[loc[0]][loc[1]] = Piece.new(dup_board, color, loc)
		end
		dup_board
	end
	
	def move(grab, destination)
		selected_piece = @rows[grab[0]][grab[1]]
		selected_piece.force_jump
		move!(grab, destination)
	end
	
	def move!(grab, destination)
		selected_piece = @rows[grab[0]][grab[1]]
		@rows[destination[0]][destination[1]] = selected_piece
		selected_piece.pos = destination
		@rows[grab[0]][grab[1]] = nil
		system("clear")
		puts draw
	end
end