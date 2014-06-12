class Piece
	BLACK = [
		[1, 1],
		[1, -1]
	]
	
	RED =[
		[-1, 1],
		[-1, -1]
	]
	
	BOUNDS = (1..8).to_a.product((1..8).to_a)
	
	attr_accessor :color
	
	def initialize(board, color, pos)
		raise "color error" unless [:RED, :BLACK].include? (color)
		@color = color
		@pos = pos
		@king = false
		@color == :RED ? @dir = RED : @dir = BLACK
		@board = board
	end
	
	def to_s
		 @color == :RED ? "o" : "*"
	end
	
	def moves
		slide 
	end
	
	def slide
		possible = []
		@dir.each do |dir|
			possible << [@pos[0] + dir[0], @pos[1] + dir[1]]
		end
		possible.select!{ |move| in_bounds(move) }
		possible.select!{ |move| is_open?(move) }
	end
	
	def jump
		possible_jump = []
		@dir.each do |dir|
			possible_jump << [(@pos[0] + (2 * dir[0])),(@pos[1] + (2 * dir[1]))]
		end
		possible_jump.select!{ |move| in_bounds(move) }
		# possible.select{ |move| is_jumpable?(move)}
	end
	
	def in_bounds(pos)
		BOUNDS.include?(pos)
	end
	
	def is_open?(pos)
		@board.rows[pos[0]][pos[1]].nil?
	end
	
#  def is_jumpable?(pos)
# 		possible_jump = []
# 		possible_dest = []
# 		@dir.each do |dir|
# 			board.[[@pos[0] + dir[0]][@pos[1] + dir[1]].color != @color
# 			possible_dest << [(@pos[0] + (2 * dir[0])),(@pos[1] + (2 * dir[1]))]
# 			possible_jump << possible_dest.select{ |move| in_bounds(move) }
# 		end
# 		possible_jump
# 	end
	
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