load './board.rb'
load './piece.rb'
class Game
	def initialize		
		@board = Board.new
		@player1 = Player.new(:RED)
		@player2 = Player.new(:BLACK)
		@turn = player1.color
	end
	
	def won?
		pieces = @board.pieces_list.select {|piece| piece.color == color}
		return true if pieces.empty?
		pieces.each do |piece|
			return false if piece.valid_slide || piece.valid_jumps
		end
		true
	end
	
	def play
		until won?
			begin
				p "Please make your selection"
				selection = gets.chomp
				selection.to_i!
				selection = selection.split(",")
				piece = @board.rows[selection[1]][selection[0]]
				raise 'Not your turn' unless piece.color == @turn
				p "Please select an end destination"
				destination = gets.chomp
				destination.to_i!
				
			
			@turn = !@turn
			rescue
				p 'Invalid selection please try again'
			end
		end
		
	end
	
	
end

class Player
	attr_reader :color
	def initialize(color)
		@color = color
	end
	
end