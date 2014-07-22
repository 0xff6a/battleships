require 'player'

	describe Player do 

	let(:player)  	{Player.new																							}	
	let(:ship)			{ double :ship, :shield_level => 2											}
	let(:destroyer) {double :destroyer																			}

	before(:each)		{ allow(STDOUT).to receive(:puts)												}
	
	context 'At start of game' do

		it "should have a grid when created" do 
			expect(player.grid.is_a?(Grid)).to be true
		end

		it "should be able to place a ship" do 
			at_coordinates = ['A1', 'A2', 'A3']
			expect(destroyer).to receive(:deploy_to).with(player.grid, at_coordinates)
			player.deploy(destroyer, at_coordinates)
		end

		it 'should be able to place all the ships' do
			allow(player).to receive(:request_coordinate_to_place)
			expect(player).to receive(:deploy).with(ship, nil)
			expect(player).to receive(:deploy).with(destroyer, nil)
			player.deploy_ships([ship, destroyer])
		end

	end

	context 'During the game' do

		it "should be able to shoot at opponent\'s board" do 
			other_grid  = Player.new.grid
			at_coordinate    = 'A1'
			expect(other_grid).to receive(:attack_cell).with(at_coordinate)
			player.shoot_at(other_grid, at_coordinate)
		end

	end

	context 'requesting coordinates' do

		it 'can request a coordinate to attack' do
			msg = "Please enter a coordinate to attack (e.g a1):"
			expect(STDOUT).to receive(:puts).with(msg)
			expect(player).to receive(:get_coordinate_from_user).and_return("A1".downcase.to_sym)
			expect(player.request_coordinate_to_attack).to eq :a1
		end

		it 'can generate a coordinate set from a start and end coordinate' do
			expect(player.generate_coordinates("a1", "a3")).to eq [:a1, :a2, :a3]
			expect(player.generate_coordinates("a1", "c1")).to eq [:a1, :b1, :c1]
		end

		it 'can check if coordinates are valid for a ship - number of coords' do
			expect(player.valid_coordinates?(ship,[:a1, :a2, :a3] )).to be false
		end

		it 'can check if coordinates are valid for a ship - same row or column' do
			expect(player.valid_coordinates?(ship,[:a1, :b2,] )).to be false
			expect(player.valid_coordinates?(ship,[:a1, :a2,] )).to be true
		end

		it 'can check if coordinates are valid for a ship - all cells vacant' do
			expect(player).to receive(:all_coordinates_vacant?).and_return(false)
			expect(player.valid_coordinates?(ship,[:a1, :a2,] )).to be false
		end

		it 'should check if coordinates are valid - belong to grid' do
			expect(player.valid_coordinates?(ship, [:j11, :j12])).to be false
		end

		it ' can request a start_coordinate' do
			msg = "Enter coordinate to place start of #{ship.class}"
			expect(STDOUT).to receive(:puts).with(msg)
			expect(player).to receive(:get_coordinate_from_user).and_return("A1".downcase.to_sym)
			expect(player.start_coordinate(ship)).to eq :a1
		end
		
		it 'can request a coordinate to place a ship' do
			expect(player).to receive(:start_coordinate).and_return(:a1)
			expect(player).to receive(:end_coordinate).and_return(:a2)
			expect(player).to receive(:valid_coordinates?).and_return(true)
			expect(player.request_coordinate_to_place(ship)).to eq [:a1, :a2]
		end

	end

end