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

func _process(delta):
	if global.selected_pawn_name != "-":
		show_moves()
	elif $AvailibleSteps.get_used_rect():
		$AvailibleSteps.clear()
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

func pawn_retreat(name):
	var tmp = get_node(name)
	
	tmp.is_chosen = false
	tmp.was_moved = false
	tmp.jumped = false
	tmp.pos = global.selected_pawn_pos
	tmp.position = $BoardTiles.map_to_world(tmp.pos) + tile_center

func mouse_handler(event):
	if event.button_index == BUTTON_LEFT and event.pressed:
		var pos = $BoardTiles.world_to_map(event.position)

		# Move pawn to selected position if it is ok
		var current_pawn2 = get_node(global.selected_pawn_name)
		print(current_pawn2.pos.x - pos.x, " ", current_pawn2.pos.y - pos.y)
		if global.selected_pawn_name != "-" and is_available_move(pos):
			var current_pawn = get_node(global.selected_pawn_name)

			current_pawn.position = $BoardTiles.map_to_world(pos) + tile_center
			print(current_pawn.pos.x - pos.x, " ", current_pawn.pos.y - pos.y)
			if abs(current_pawn.pos.x - pos.x) == 2 \
					or abs(current_pawn.pos.y - pos.y) == 2:
				current_pawn.jumped = true
			current_pawn.pos = pos
			current_pawn.was_moved = true

func show_moves():
	var selected_pawn = get_node(global.selected_pawn_name)

	if $AvailibleSteps.get_used_rect():
		$AvailibleSteps.clear()
	for x in range(-2, 3):
		for y in range(-2, 3):
			var cell_pos = selected_pawn.pos + Vector2(x, y)
			if is_available_move(cell_pos):
				$AvailibleSteps.set_cellv(cell_pos, 0)

func is_available_move(pos):
	var selected_pawn = get_node(global.selected_pawn_name)
	var distance = selected_pawn.pos - pos

	if pos.x > 7 or pos.x < 0 or pos.y > 7 or pos.y < 0:
		return false
	if (!selected_pawn.was_moved or selected_pawn.jumped) \
			and global.grid[pos.x][pos.y] == EMPTY:
		if abs(distance.x) <= 1 and abs(distance.y) <= 1 and !selected_pawn.jumped:
			return true
		elif distance.abs() == Vector2(2, 0) \
				or distance.abs() == Vector2(0, 2) \
				or distance.abs() == Vector2(2, 2):
			distance.x = pos.x + int(distance.x / 2)
			distance.y = pos.y + int(distance.y / 2)
			if global.grid[distance.x][distance.y] != EMPTY:
				return true 
	return false
# Functions END