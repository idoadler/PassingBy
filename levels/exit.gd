extends Area2D

export(String, FILE, "*.tscn") var next_scene

func _on_Exit_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.name == "Player"):
		get_tree().change_scene(next_scene)