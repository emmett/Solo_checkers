require_relative 'piece'

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
				next if color == :BLACK && row_idx > 3
				next if color == :RED && row_idx < 5
				row[col_idx] = Piece.new(self, color, [row_idx, col_idx])
			end
		end
	end

	
	def draw
		@rows.map do |row|
			row.map do |square|
				square.nil? ? "." : square.to_s
			end.join(" ")
		end.join("\n")
	end
	
	
end