extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tile_size = get_node("BoardTiles").get_cell_size()
var board_size = Vector2(8, 8)

onready var Pawn = preload("res://ToddPawnBase.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
