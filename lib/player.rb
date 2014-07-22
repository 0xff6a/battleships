require './lib/grid'
require './lib/cell'
require 'terminal-table'

class Player

	attr_accessor :grid

	def initialize
		@grid = Grid.new(size: 10)
	end

	def deploy_ships(ships)
		ships.each do |ship| 
			deploy(ship, request_coordinate_to_place(ship))
			print_own_grid
		end
	end

	def print_own_grid
		display_grid(false)
	end

	def deploy(ship, at_coordinates)
		ship.deploy_to(grid, at_coordinates)	
	end	

	def shoot_at(opponent_grid, at_coordinate)
		opponent_grid.attack_cell(at_coordinate)
	end

	#Requesting attack coordinates

	def request_coordinate_to_attack
		puts "Please enter a coordinate to attack (e.g a1):"
		get_coordinate_from_user
	end

	def get_coordinate_from_user
		gets.chomp.downcase.to_sym
	end

	#Requesting coordinates to place ship

	def request_coordinate_to_place(ship)
		coordinates = generate_coordinates(start_coordinate(ship), end_coordinate(ship))
			until valid_coordinates?(ship, coordinates)
				coordinates = generate_coordinates(start_coordinate(ship), end_coordinate(ship))
			end
		coordinates
	end

	def generate_coordinates(first, last)
		first_letter,first_number = letter(first), number(first)
		last_letter,last_number = letter(last), number(last)
		
		return fill_column(first_number, last_number, first_letter) if same_letters?(first_letter, last_letter)
		fill_row(first_letter, last_letter, first_number)
	end

	def fill_column(first_number, last_number, first_letter)
		(first_number..last_number).to_a.map{ |number| (first_letter + number.to_s).to_sym}
	end

	def fill_row(first_letter, last_letter, first_number)
		(first_letter..last_letter).to_a.map{ |letter| (letter + first_number.to_s).to_sym }
	end

	def same_letters?(first_letter, last_letter)
		first_letter == last_letter
	end

	def valid_coordinates?(ship, coordinates)
		return false unless on_grid?(coordinates)
		return false unless all_coordinates_vacant?(coordinates)
		return false unless have_shared_row_or_column?(coordinates)
		return false unless correct_number_of?(coordinates, ship)
		true
	end

	def on_grid?(coordinates)
		coordinates.each { |coordinate| grid.cell(coordinate) }
		true
	rescue
		false
	end

	def correct_number_of?(coordinates, ship)
		coordinates.count == ship.shield_level
	end

	def have_shared_row_or_column?(coordinates)
		shared_row?(coordinates) or shared_column?(coordinates)
	end

	def shared_column?(coordinates)
		coordinates.all?{ |coordinate| letter(coordinate) == letter(coordinates.first) }
	end

	def shared_row?(coordinates)
		coordinates.all?{ |coordinate| number(coordinate) == number(coordinates.first) }
	end

	def all_coordinates_vacant?(coordinates)
		coordinates.all?{ |coordinate| vacant?(coordinate) }
	end

	def vacant?(coordinate)
		grid.cell(coordinate).occupied? == false
	end

	def start_coordinate(ship)
		puts "Enter coordinate to place start of #{ship.class}"
		get_coordinate_from_user
	end

	def end_coordinate(ship)
		puts "Enter coordinate to place end of #{ship.class} that spans #{ship.shield_level} cells"
		get_coordinate_from_user
	end

	#Grid user interface

	def display_grid(hide_ships = true)
		content = create_content(hide_ships)
		content = index_rows(content)
		table = create_table(content)
		puts table
	end

	def create_content(hide_ships)
		grid.cells.map{|row| row.map{|cell| cell.display(hide_ships)}}
	end

	def index_rows(content)
		indexed_rows = []
		content.each_with_index do |row, index|
			indexed_rows << [index+1] + row
		end
		indexed_rows
	end

	def create_table(content)
		Terminal::Table.new title: "Battle Royale... At Sea", headings: ['/'] + ('a'..'j').to_a, rows: content
	end

end

def letter(coordinate)
	coordinate[0]
end

def number(coordinate)
	coordinate[1..2].to_i
end



