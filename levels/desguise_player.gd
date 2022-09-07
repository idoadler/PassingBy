extends TouchScreenButton

onready var player: = $"%Player"

func _ready():
	get_parent().set_visible(PlayerVariables.touch)

func _on_TouchScreenButton_pressed():
	player.disguise()
