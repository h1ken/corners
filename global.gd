extends Node

signal chosed_another_pawn

# Game state variables
var current_player_turn
var turn_number

var selected_pawn_name = "-"
var selected_pawn_pos = Vector2(-1, -1)


# Grid representation of board
var grid = []

func _ready():
	pass
