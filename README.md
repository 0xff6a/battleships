Battleships
===========
 
 Team Incas : Catherina, Hannah, Jeremy, Peter
 
 Week 4 Project: Create an interactive battleships game
 
 Battleships is a two player game. Each player deploys 5 ships on a 10 x 10 grid. Each cell has a unique grid reference. Each player takes turns to call out a grid reference and the other players confirms whether it is a ‘hit’ or ‘miss’ if a ship is at that grid reference or not. The attacking players marks the ‘hit’ or ‘miss’ on their tracking grid. The defending player marks ‘hit’ or ‘miss’ on their primary grid. Players alternate turns. When every cell that comprises one ship has been ‘hit’, the defending player declares it sunk. When a player sinks all their opponent’s ships they win and the game ends.
 
Classes
=======
 
Grid
-----

The grid manages the collection of cells. 
 
Attributes:
 
- Size: the grid has a length and a width (defaults to square 10x10). These are set on initialisation
- Cells: the grid holds an array of cells 
- Ships: the grid holds an array of ships
 
Methods:
 
- Update -> collaborates with Cell. Updates cell attributes based on hit/miss
- Hit_or_miss -> collaborates with Cell. Checks whether player has scored a hit or a miss on the grid
 
Player
---------
Methods: 
- Deploy ships to the grid. This should be done by giving the grid references of the cells occupied by the ships. 
- Attck the grid. This is done by declaring the grid reference of the cell that it would like to attack. 
 
Attributes:
- Each player possess two grids. 
(We anticipate that this might change, as the tracking grid is the same as the primary grid of the opposing player, minus the ships that have been deployed.)
 
Cell
----- 
Upon initialisation a cell should:
- A grid reference
- Each cell has a grid reference.
 
Each cell should know whether:
- it has been previously attacked or not
- it is occupied or empty. 
 
Game
----
Upon start of the game:
- it should make 2 players
- it should make 4 grids
- it should make 10 tests
- it should instructions for deployment
 
Round n:
- it should start the game
- it should set turns
- it should declare victory
- it should end the game
 
Ship
-----
Ships are created by the Game and deployed to the Grid by the Players.
 
Attributes:
 
- size(how many cells)
- location(which cells it occupies)
- name(e.g. aircraft carrier)
 
A ship should know:
- if it has been hit 
- how many times it has been hit
- if it has been sunk or not