extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var black_band = preload("art/black_band.png")
var white_band = preload("art/white_band.png")

enum BAND_COLOR { NONE, WHITE_BAND, BLACK_BAND }
export (BAND_COLOR) var wearing = BAND_COLOR.NONE

# Called when the node enters the scene tree for the first time.
func _ready():
	if wearing == BAND_COLOR.WHITE_BAND:
		$Band.texture = white_band
	elif wearing == BAND_COLOR.BLACK_BAND:
		$Band.texture = black_band
		$Band.flip_h = true
		flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
