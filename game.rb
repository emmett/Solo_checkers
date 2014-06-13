load './board.rb'
require 'debugger'

class Game
	attr_reader :board
	
	def initialize		
		@board = Board.new
		@player1 = Player.new(:RED)
		@player2 = Player.new(:BLACK)
		@turn = @player1.color
	end
	
	def lost?
		pieces = @board.pieces_list.select {|piece| piece.color == @turn }
		return true if pieces.empty?
		pieces.each do |piece|
			return false unless piece.valid_slide.empty? && piece.valid_jumps.empty?
		end
		true
	end
	
	def play
		until lost?

			begin
				move_list = []
				done = false
				p "Please make your selection"
				p "#{@turn} Turn"
				selection = gets.chomp
				selection = selection.split(",")
				move_list << selection.map! { |coord| coord.to_i }
				piece = @board.rows[selection[0]][selection[1]]
				raise 'Not your turn' unless piece.color == @turn
				until done
					p "Please select an end destination"
					destination = gets.chomp
					destination = destination.split(",")
					destination.map! { |coord| coord.to_i }	
					move_list << destination		
					p "Is there another destination? (Y/N)"
					answer = gets.chomp
					done = true if answer[0].downcase == "n" 
				end
				@board.valid_move_seq(move_list)
				@turn == :RED ? @turn = :BLACK : @turn = :RED
				
			rescue RuntimeError => e
				p e.message
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

# 
# raise "String", NewError
# 
# class NewError < Stderro
# end