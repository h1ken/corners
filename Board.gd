extends PanelContainer

# Enum for grid
enum { EMPTY, WHITE, BLACK }

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
	init_game_state()
	init_pawns()
	global.connect("chosed_another_pawn", self, "_on_Pawn_chosed_another_pawn")

func _process(delta):
	pass

func _gui_input(event):
	if event is InputEventMouseButton:
		mouse_handler(event)

# Block of new functions
func init_game_state():
	init_grid()
	global.current_player_turn = WHITE
	global.turn_number = 1

func init_grid():
	for x in range(board_size.x):
		global.grid.append([])
		for y in range(board_size.y):
			global.grid[x].append(EMPTY)

# Place pawns on board and fill grid
#  Need to do research about what should I do with "x / PAWNS_IN_ROW", cause I don't think it is good idea to ignore warning
func init_pawns():
	for x in range(PAWNS_QUANTITY):
		# Starting from top-left cell, place black pawns on board
		var tmp_coord = Vector2(x % PAWNS_IN_ROW, x / PAWNS_IN_ROW)
		new_todd(tmp_coord, BLACK)

		# Starting from bottom-right cell, place white pawns on board
		tmp_coord = board_size - Vector2(1, 1) - tmp_coord
		new_todd(tmp_coord, WHITE)

func new_todd(pos, band_color):
	var tmp_todd = Pawn.instance()

	tmp_todd.wearing = band_color
	tmp_todd.position = $BoardTiles.map_to_world(pos) + tile_center
	tmp_todd.pos = pos
	global.grid[pos.x][pos.y] = band_color
	self.add_child(tmp_todd)

func _on_Pawn_chosed_another_pawn():
	var tmp = get_node(global.selected_pawn_name)
	tmp.pos = global.selected_pawn_pos
	tmp.position = $BoardTiles.map_to_world(tmp.pos) + tile_center
	print("PZL")

func mouse_handler(event):
	if event.button_index == BUTTON_LEFT and event.pressed:
		var pos = $BoardTiles.world_to_map(event.position)
		if global.selected_pawn_name != "-" and global.grid[pos.x][pos.y] == EMPTY:
			var current_pawn = get_node(global.selected_pawn_name)
			current_pawn.position = $BoardTiles.map_to_world(pos) + tile_center
			current_pawn.pos = pos
			current_pawn.was_moved = true
		# If no chosen pawn, check is there a pawn under cursor
		# If pawn is chosen and under cursor is another one, return to prev state and choose new pawn
		# If pawn was moved and chosen again, end turn
		#   If it wasn't moved, unchoose
		# If under cursor is possible position, move pawn 
# Functions END