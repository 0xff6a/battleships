require 'ship'

shared_examples 'ship' do

let(:ship)		{ Ship.new }
let(:weak_ship) { Ship.new(shield_level: 1) }
let(:cell)		{ double :cell, :occupier= => nil }
let(:grid)		{ double :grid, :cell => cell }

context ''

	it 'should not be sunk when created' do 
		expect(ship).not_to be_sunk
	end

	it 'should have a shield_level' do
		expect(ship.shield_level).to eq 3
	end

	it 'shield_level can be set when created' do
		expect(ship.shield_level).to eq Ship::DEFAULT_SHIELD_LEVEL
	end

	it 'should know if it\'s been sunk' do 
		ship.sink!
		expect(ship).to be_sunk
	end

	it 'shield level should reduce by 1 when attacked' do
		expect(ship.attack!.shield_level).to eq (Ship::DEFAULT_SHIELD_LEVEL) -1
	end

	it 'an attack should sink a ship with shield level 1' do
		weak_ship.attack!
		expect(weak_ship).to be_sunk
	end

	it 'should deploy a ship to a given grid coordinate' do
		expect(cell).to receive(:occupier=).with(weak_ship)
		weak_ship.deploy_to(grid, [:a1]) 
	end


	it 'should deploy a ship to a given set of grid coordinates' do
		expect(cell).to receive(:occupier=).with(ship).exactly(3).times
		ship.deploy_to(grid, [:a1, :a2, :a3]) 
	end

end

describe AircraftCarrier do

	it 'should make an aircraft carrier have shield_level 5' do
		expect(AircraftCarrier.new.shield_level).to be 5
	end

	it_behaves_like 'ship'

end

describe Battleship do 

	it 'should make an battleship have shield_level 4' do
		expect(Battleship.new.shield_level).to be 4
	end

	it_behaves_like 'ship'

end

describe PatrolBoat do

	it 'should make a patrol boat have shield_level 2' do
		expect(PatrolBoat.new.shield_level).to be 2
	end		

	it_behaves_like 'ship'

end

describe Submarine do

	it_behaves_like 'ship'

end

describe Destroyer do

	it_behaves_like 'ship'

end