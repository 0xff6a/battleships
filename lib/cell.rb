require './lib/water'
require './lib/attacked_cell'
require './lib/hit'
require './lib/miss'


class Cell 

	DEFAULT_REFERENCE = nil

	attr_accessor :occupier

	def initialize
		@occupier = Water.new 
	end

	def occupied?
		!@occupier.is_a?(Water)
	end

	def occupy_with(ship)
		@occupier = ship
		self
	end

	def attack!
		@occupier.attack!
		return score_hit if occupied?
		score_miss
	end

	def score_hit
		puts "HIT"
		return Hit.new
	end

	def score_miss
		puts "MISS"
		Miss.new
	end
	
	def display(hide_ships = true)
		return "-" if hide_ships
		return '@' if occupied? 
		'~'
	end
	
end