extends Sprite

# Enum for adding a band to Todd
enum BAND_COLOR { NONE, WHITE_BAND, BLACK_BAND }

# Consts

# Consts END

# Variables

# New option to choose band in editor
export (BAND_COLOR) var wearing = BAND_COLOR.NONE

# Preload of textures for bands
var black_band = preload("art/black_band.png")
var white_band = preload("art/white_band.png")

# Some flags to work with
var is_chosen = false
var was_moved = false

# Position in grid
var pos

# Variables END

# Functions

# Override block
func _ready():
	if wearing == BAND_COLOR.WHITE_BAND:
		$Band.texture = white_band
	elif wearing == BAND_COLOR.BLACK_BAND:
		$Band.texture = black_band
		$Band.flip_h = true
		flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_CenterContainer_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if global.current_player_turn == self.wearing:
			if self.is_chosen:
				unchoose_self()
				if self.was_moved:
					end_turn()
			else:
				choose_self()

# Pawn functions
func pawn_going_to(direction):
	pos += direction

func choose_self():
	if global.selected_pawn_name != "-":
		global.emit_signal("chosed_another_pawn")
	self.is_chosen = true
	global.selected_pawn_name = self.name
	global.selected_pawn_pos = pos

func unchoose_self():
	self.is_chosen = false
	global.selected_pawn_name = "-"
	global.selected_pawn_pos = Vector2(-1, -1)

func end_turn():
	self.was_moved = false
	global.turn_number += 1
	global.current_player_turn = 3 - global.current_player_turn

# Functions END