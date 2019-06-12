extends Sprite

# Enum for adding a band to Todd
enum BAND_COLOR { NONE, WHITE_BAND, BLACK_BAND }

# Consts

# Pawn movement
const MOVE_UP = Vector2(0, -1)
const MOVE_DOWN = Vector2(0, 1)
const MOVE_LEFT = Vector2(-1, 0)
const MOVE_RIGHT = Vector2(1, 0)

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
var pos = Vector2(-1, -1)

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

# Pawn functions
func pawn_going_to(direction):
	pos += direction

# Functions END

func _on_CenterContainer_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		print(name)
