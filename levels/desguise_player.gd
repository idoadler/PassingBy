extends TouchScreenButton

@onready var player: = $"//root/Node2D/Player"

func _ready():
	get_parent().set_visible(PlayerVariables.touch)

func _on_TouchScreenButton_pressed():
	print(player)
	print(get_tree().get_current_scene().get_name())
	player.disguise()
