extends Node

# Signal for new turn
signal turn_end

# Game state variables
var current_player_turn
var turn_number = 1 setget turn_end

var selected_pawn_name = "-"
var selected_pawn_pos = Vector2(-1, -1)


# Grid representation of board
var grid = []

func _ready():
	pass

func turn_end(value):
	if value == 1:
		turn_number = 1;
	else:
		turn_number = value
		emit_signal("turn_end")
	pass