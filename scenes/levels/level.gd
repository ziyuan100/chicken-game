extends Node2D
var drumstick_scene: PackedScene = preload("res://scenes/objects/drumstick.tscn")

func _on_drumstick_player_hit():
	print("hit!")
	$Player.alive = false

func _on_spawn_timer_timeout():
	var numbers: Array = [1,2,2,2,2,3,3]
	for i in numbers[randi() % len(numbers)]:
		var pos_x: float = Globals.player_pos.x + randf_range(-800, 800)
		var pos_y: float = Globals.player_pos.y - randf_range(1000, 1500)
		var pos = Vector2(pos_x, pos_y)
		create_drumstick(pos)
	Globals.score += 1

func create_drumstick(pos):
	var drumstick = drumstick_scene.instantiate() as RigidBody2D
	drumstick.position = pos
	$Objects.add_child(drumstick)


func _on_player_player_lost():
	$SpawnTimer.stop()
	$UI.show_game_over()
	if (Globals.score > Globals.high_score):
		Globals.high_score = Globals.score

func _on_ui_start_game():
	$SpawnTimer.start()
	Globals.score = 0
	$Player.alive = true
	Globals.can_move = true
