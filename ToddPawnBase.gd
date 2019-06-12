extends Sprite

# Enum for adding a band to Todd
enum BAND_COLOR { NONE, WHITE_BAND, BLACK_BAND }

# Variables

# New option to choose band in editor
export (BAND_COLOR) var wearing = BAND_COLOR.NONE

# Preload of textures for bands
var black_band = preload("art/black_band.png")
var white_band = preload("art/white_band.png")

# Some flags to work with
var is_chosen = false
var was_moved = false

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

# Functions END