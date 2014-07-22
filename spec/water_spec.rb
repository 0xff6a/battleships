require 'water'

describe Water do 
	
	it 'should return self when attacked' do 
		water = Water.new
		expect(water.attack!).to eq(water)
	end 

end 