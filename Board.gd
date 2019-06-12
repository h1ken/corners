extends PanelContainer

# Enum for grid
enum { EMPTY, BLACK, WHITE }

# Consts

# For changing board size
const BOARD_WIDTH = 8
const BOARD_HEIGT = BOARD_WIDTH

# For creating pawns
const PAWNS_QUANTITY = 9
const PAWNS_IN_ROW = 3

# Consts END

# Variables

# For creating new instances of Todd-pawns
onready var Pawn = preload("res://ToddPawnBase.tscn")

# Board
var board_size = Vector2(BOARD_WIDTH, BOARD_HEIGT)
var board_grid = []

# Needed for manipulation with graphical representation of board
onready var tile_size = $BoardTiles.get_cell_size()
onready var tile_center = tile_size / 2

# Variables END

# Functions

# Override block
func _ready():
	init_grid()
	init_pawns()

func _process(delta):
	pass

func _gui_input(event):
	if event is InputEventMouseButton:
		mouse_handler(event)

# Block of new functions

func init_grid():
	for x in range(board_size.x):
		board_grid.append([])
		for y in range(board_size.y):
			board_grid[x].append(EMPTY)

# Place pawns on board and fill grid
#  Need to do research about what should I do with "x / PAWNS_IN_ROW", cause I don't think it is good idea to ignore warning
func init_pawns():
	for x in range(PAWNS_QUANTITY):
		# Starting from top-left cell, place black pawn on board
		var tmp_todd = Pawn.instance()
		var tmp_coord = Vector2(x % PAWNS_IN_ROW, x / PAWNS_IN_ROW)

		tmp_todd.wearing = tmp_todd.BAND_COLOR.BLACK_BAND
		tmp_todd.position = $BoardTiles.map_to_world(tmp_coord) + tile_center
		board_grid[tmp_coord.x][tmp_coord.y] = BLACK
		self.add_child(tmp_todd)

		# Starting from bottom-right cell, place white pawn on board
		tmp_coord = board_size - Vector2(1, 1) - tmp_coord
		tmp_todd = Pawn.instance()

		tmp_todd.wearing = tmp_todd.BAND_COLOR.WHITE_BAND
		tmp_todd.position = $BoardTiles.map_to_world(tmp_coord) + tile_center
		board_grid[tmp_coord.x][tmp_coord.y] = WHITE
		self.add_child(tmp_todd)

func mouse_handler(event):
	if event.button_index == BUTTON_LEFT and event.pressed:
		var pos = $BoardTiles.world_to_map(event.position)
		
		# If no chosen pawn, check is there a pawn under cursor
		# If pawn is chosen and under cursor is another one, return to prev state and choose new pawn
		# If pawn was moved and chosen again, end turn
		#   If it wasn't moved, unchoose
		# If under cursor is possible position, move pawn 
# Functions END