require 'attacked_cell'

describe AttackedCell do

let(:attacked_cell) {AttackedCell.new}

	it 'can not be attacked' do 
		expect(lambda{attacked_cell.attack!}).to raise_error(RuntimeError) 
	end

end