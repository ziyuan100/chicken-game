extends Node
signal score_change

var player_pos: Vector2
var score: int = 0:
	set(value):
		score = value
		score_change.emit()

var high_score: int = 0

var can_move: bool = false
