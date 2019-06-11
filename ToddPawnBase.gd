extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var black_band = preload("art/black_band.png")
var white_band = preload("art/white_band.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# My try to learn init
func _init(color):
	var band = get_node("Band")
	if color == "W":
		band.texture(white_band)
	elif color == "B":
		band.texture(black_band)