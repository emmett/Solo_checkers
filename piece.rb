require 'debugger'

class Piece
	BLACK = [
		[1, 1],
		[1, -1]
	]
	
	RED =[
		[-1, 1],
		[-1, -1]
	]
	
	BOUNDS = (0..7).to_a.product((0..7).to_a)
	
	attr_accessor :color, :pos, :board
	
	def initialize(board, color, pos)
		raise "color error" unless [:RED, :BLACK].include? (color)
		@color, @pos, @board = color, pos, board
		@king = false
		@color == :RED ? @dir = RED : @dir = BLACK
		board.add_piece(self, pos)
	end
	
	def to_s
		if @king
			@color == :RED ? "K" : "@"
		else
			@color == :RED ? "o" : "*"
		end
	end
	
	def moves
		
	end
	
	def perform_jump(end_dest)
		midpoint = [(pos[0] + end_dest[0]) / 2, (pos[1] + end_dest[1]) / 2]
		raise 'invalid_jump' unless valid_jumps.include? (end_dest)
		@board.move!(self.pos, midpoint)
		@board.move!(midpoint, end_dest)
		self.pos = end_dest
	end
	
	def perform_slide(end_dest)
		raise 'Not a valid move' unless valid_slide.include? (end_dest)
		raise 'Forced to jump' if force_jump
		@board.move!(self.pos, end_dest)
		self.pos = end_dest
	end
	
	def valid_slide
		possible_slide = []
		@dir.each do |dir|
			possible_slide << [@pos[0] + dir[0], @pos[1] + dir[1]]
		end
		possible_slide = possible_slide.select{ |move| in_bounds(move) }
		return possible_slide.select{ |move| is_open?(move) }
	end
	
	def valid_jumps
		possible_jump = []
		@dir.each do |dir|
			adj_piece = board.rows[@pos[0] + dir[0]][@pos[1] + dir[1]]
			dest_square = board.rows[@pos[0] + (2 * dir[0])][@pos[1] +(2 * dir[1])]
			next if adj_piece == nil || adj_piece.color == @color
			next unless dest_square.nil?
			possible_jump << [(@pos[0] + (2 * dir[0])),(@pos[1] + (2 * dir[1]))]
		end
		return possible_jump.select{ |move| in_bounds(move) }
	end
	
	def jumps
		pieces = @board.pieces_list.select {|piece| @color == self.color}
		jumps = []
		pieces.each do |piece|
			jumps += piece.pos unless valid_jumps.empty?
		end
		jumps
	end
	
	def force_jump
		true if jumps.count > 0
	end
	
	def in_bounds(pos)
		BOUNDS.include?(pos)
	end
	
	def is_open?(pos)
		@board.rows[pos[0]][pos[1]].nil?
	end
	
	def king_me
		if color = :RED && pos[0] = 8
			@king = true
			@dir = DOWN + UP
		end
		
		if color = :BLACK && pos[0] = 1
			@king = true
			@dir = DOWN + UP
		end
	end
end
