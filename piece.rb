class Piece
	UP = [
		[1, 1],
		[1, -1]
	]
	
	DOWN =[
		[-1, 1],
		[-1, 1]
	]
	
	def initialize(board, color, pos)
		raise "color error" unless [:red, :black].include? (color)
		@color = color
		@pos = pos
		@king = false
		@color == :red ? @dir = DOWN : @dir = UP
		@board = board
	end
	
	def moves
		slide + jumpable
	end
	
	def slide
		possible = []
		@dir.each do |dir|
			possible << [pos[0] + dir[0], pos[1] + dir[1]]
		end
		
		possible.select{ |move| if is_open?(move)}
	end
	
	def jump
		possible = []
		@dir.each do |dir|
			possible << [pos[0] + dir[0], pos[1] + dir[1]]
		end
		
		possible.select{ |move| if is_jumpable?(move)}
	end
	
	def is_open?(pos)
		board[pos[0], pos[1]].empty?
	end
	
	def is_jumpable?(pos)
		board[pos[0], pos[1]].color != @color && pos[0]
	end
	
	def king_me
		if color = :red && pos[0] = 8
			@king == true
			@dir == DOWN + UP
		end
		if color = :black && pos[0] = 1
			@king == true
			@dir == DOWN + UP
		end
	end
	
end