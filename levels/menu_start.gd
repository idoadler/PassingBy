extends Node2D

@onready var door = $"%Exit"

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		PlayerVariables.touch = false
		door._next_room()

func _on_TouchScreenButton_pressed():
	PlayerVariables.touch = true
	door._next_room()
