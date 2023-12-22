extends TileMap

func _on_left_edge_screen_entered():
	spawn_tileset(false)


func _on_right_edge_screen_entered():
	spawn_tileset(true)

func spawn_tileset(is_right):
	var new_tile = self.duplicate()
	new_tile.z_index = -1
	if (is_right):
		new_tile.position.x = position.x + 3000
	else:
		new_tile.position.x = position.x - 3000
	get_parent().add_child(new_tile)
	queue_free()
