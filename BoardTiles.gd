extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Pawn = preload("res://ToddPawnBase.tscn")

var tile_size = get_cell_size()
var tile_center = tile_size / 2
var board_size = Vector2(8, 8)

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(3):
		for y in range(3):
			var tmp_todd = Pawn.instance()

			tmp_todd.wearing = tmp_todd.BAND_COLOR.BLACK_BAND
			tmp_todd.position = map_to_world(Vector2(x, y)) + tile_center
			add_child(tmp_todd)
			tmp_todd = Pawn.instance()
			tmp_todd.wearing = tmp_todd.BAND_COLOR.WHITE_BAND
			tmp_todd.position = map_to_world(Vector2(7 - x, 7 - y)) + tile_center
			add_child(tmp_todd)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
