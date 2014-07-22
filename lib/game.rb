require './lib/player'
require './lib/ship'

class Game

	attr_accessor :current_player, :other_player

	def initialize
			@current_player = player_factory
			@other_player = player_factory
	end

	def players
		[@current_player, @other_player]
	end

	def player_factory
		Player.new
	end

	def ship_factory
		[ AircraftCarrier.new,
			Battleship.new,
			Destroyer.new,
			Submarine.new,
			PatrolBoat.new
		]
	end

	def start_game
		current_player.display_grid
		print_player1_prompt
		current_player.deploy_ships(ship_factory)
		print_player2_prompt
		other_player.deploy_ships(ship_factory)
		print_start_message
		play_game
	end

	def print_start_message
		puts "----START----"
	end

	def print_player1_prompt
		puts "Player 1 Start"
	end

	def print_player2_prompt
		puts "Player 2 Start"
	end

	def change_turn
		@current_player, @other_player = @other_player, @current_player
		puts "Next player"
	end

	def play_game
		loop do
			play_turn
		end
	end

	def play_turn
		begin
			other_player.display_grid
			current_player.shoot_at(other_player.grid, current_player.request_coordinate_to_attack)
			end_game if victory_declared
			change_turn
		rescue Exception => error
			puts error.message
		end
	end

	def victory_declared
		if other_player.grid.count_sunken_ships == 5
			puts "Current player wins!" 
			true
		end
	end

	def end_game
		puts "----GAME OVER----"
		exit
	end

end
