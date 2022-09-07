extends TouchScreenButton

onready var player: = get_node("/root/Node2D/Player")

func _on_TouchScreenButton_pressed():
	player.disguise()
