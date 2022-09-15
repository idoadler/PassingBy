extends Area2D

@export var next_scene = ""# (String, FILE, "*.tscn")

func _next_room():
	get_tree().change_scene_to_file(next_scene)

func _on_Exit_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.name == "Player"):
		_next_room()
