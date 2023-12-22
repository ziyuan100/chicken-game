extends RigidBody2D
signal player_hit

func _on_area_2d_body_entered(body):
	if ("hit" in body):
		body.hit()

func _on_despawn_timer_timeout():
	queue_free()
