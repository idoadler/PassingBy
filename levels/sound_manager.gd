extends Node2D

export(float) var door_distance = 600
export(bool) var disable_transition = false

onready var button = $"Button"
onready var on_sprite = $"Sound_on"
onready var room_music = $"AudioStreamPlayer"
onready var party_music = $"AudioStreamPlayer2"
onready var door = $"%Exit"
onready var player: = $"%Player"

var door_pos

func _ready():
	if disable_transition:
		room_music.volume_db = linear2db(1)
		party_music.volume_db = linear2db(0)
	else:
		door_pos = door.get_global_position()
	button.set_pressed_no_signal(PlayerVariables.muted)
	_on_Button_toggled(PlayerVariables.muted)

func _process(delta):
	if PlayerVariables.muted:
		return
	if disable_transition:
		return
	var distance = door_pos.distance_to(player.get_global_position())
	if distance > door_distance:
		room_music.volume_db = linear2db(1)
		party_music.volume_db = linear2db(0)
	else:
		room_music.volume_db = linear2db(distance/door_distance)
		party_music.volume_db = linear2db(1-distance/door_distance)

func _on_Button_toggled(button_pressed):
	var muted = button_pressed
	PlayerVariables.muted = muted
	on_sprite.set_visible(!muted)
	room_music.set_stream_paused(muted)
	party_music.set_stream_paused(muted)
