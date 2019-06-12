extends PanelContainer

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

# Needed for manipulation with graphical representation of board
onready var tile_size = $BoardTiles.get_cell_size()
onready var tile_center = tile_size / 2

# Variables END

# Functions

# Override block
func _ready():
	init_pawns()

func _process(delta):
	pass

func _gui_input(event):
	if event is InputEventMouseButton:
		mouse_handler(event)

# Block of new functions

# Need to do research about what should I do with "x / PAWNS_IN_ROW", cause I don't think it is good idea to ignore warning
func init_pawns():
	for x in range(PAWNS_QUANTITY):
			var tmp_todd = Pawn.instance()
			var tmp_coord = Vector2(x % PAWNS_IN_ROW, x / PAWNS_IN_ROW)

			tmp_todd.wearing = tmp_todd.BAND_COLOR.BLACK_BAND
			tmp_todd.position = $BoardTiles.map_to_world(tmp_coord) + tile_center
			self.add_child(tmp_todd)
			
			tmp_coord += Vector2(1, 1)
			tmp_todd = Pawn.instance()
			tmp_todd.wearing = tmp_todd.BAND_COLOR.WHITE_BAND
			tmp_todd.position = $BoardTiles.map_to_world(board_size - tmp_coord) + tile_center
			self.add_child(tmp_todd)

func mouse_handler(event):
	if event.button_index == BUTTON_LEFT and event.pressed:
		var pos = $BoardTiles.world_to_map(event.position)
		
		# If no chosen pawn
		
# Functions END