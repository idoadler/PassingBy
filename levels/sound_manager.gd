extends Node2D

export(float) var door_distance = 600

onready var door = $"Door"
onready var on_sprite = $"Sound_on"
onready var room_music = $"AudioStreamPlayer"
onready var party_music = $"AudioStreamPlayer2"
onready var player: = get_node("/root/Node2D/Player")

var muted = false
var door_pos

func _ready():
	door_pos = door.get_global_position()

func _process(delta):
	if muted:
		return
	var distance = door_pos.distance_to(player.get_global_position())
	if distance > door_distance:
		room_music.volume_db = linear2db(1)
		party_music.volume_db = linear2db(0)
	else:
		room_music.volume_db = linear2db(distance/door_distance)
		party_music.volume_db = linear2db(1-distance/door_distance)

func _on_Button_toggled(button_pressed):
	muted = button_pressed
	on_sprite.set_visible(!muted)
	room_music.set_stream_paused(muted)
	party_music.set_stream_paused(muted)
