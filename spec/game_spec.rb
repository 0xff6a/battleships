require 'game'

describe Game do

	let(:game) 		{ Game.new																																		}
	let(:player1) { double :player1, :grid => grid1, :deploy_ships => nil, :display_grid => nil	}
	let(:player2) { double :player2, :grid => grid2, :deploy_ships => nil												}
	let(:grid1)  	{ double :grid1, :count_sunken_ships => 5 																		}
	let(:grid2)		{ double :grid2, :count_sunken_ships => 0 																		}

	context 'At the start of the game' do
	
		it 'should start with 2 instances of the player class' do
			expect(game.players[0]).to be_an_instance_of Player
			expect(game.players[1]).to be_an_instance_of Player
		end

		it 'should know which is the current player' do
			expect(game.current_player).to be game.players[0]
		end

		it 'should know which is the other player' do
			expect(game.other_player).to be game.players[1]
		end
		
		it 'can make an array of ships' do
			expect(game.ship_factory).to be_an_instance_of Array
		end

		it 'can fill the array with ships' do
			expect(game.ship_factory[0]).to be_an_instance_of AircraftCarrier
			expect(game.ship_factory[1]).to be_an_instance_of Battleship
			expect(game.ship_factory[2]).to be_an_instance_of Destroyer
			expect(game.ship_factory[3]).to be_an_instance_of Submarine
			expect(game.ship_factory[4]).to be_an_instance_of PatrolBoat
		end

		it 'can start the game' do
			game.current_player = player1
			game.other_player = player2
			expect(player1).to receive(:deploy_ships)
			expect(player2).to receive(:deploy_ships)
			expect(STDOUT).to receive(:puts).exactly(3).times
			expect(game).to receive(:play_game)
			game.start_game
		end

	end

	context 'In round n' do 

		it 'can change turns' do
			player1 = game.current_player
			expect(STDOUT).to receive(:puts).with("Next player")
			game.change_turn
			expect(game.other_player).to be player1
		end

		it 'can declare victory' do
			game.other_player = player1
			game.current_player = player2
			expect(STDOUT).to receive(:puts).with("Current player wins!")
			game.victory_declared
		end

		it 'can end the game' do
			expect(STDOUT).to receive(:puts).with("----GAME OVER----")
			expect { game.end_game }.to raise_exception(SystemExit)
		end

		it 'can stop a player attacking the same cell twice' do
			player = game.current_player
			expect(player).to receive(:shoot_at).and_return(RuntimeError)
			expect(player).to receive(:request_coordinate_to_attack)
			expect(STDOUT).to receive(:puts).twice
			game.play_turn
		end

	end

end
