extends KinematicBody2D

export var speed = 250
export var min_dist = 25

onready var animation = $"AnimationPlayer"

var start_pos
var target_pos
var last_timer = OS.get_ticks_msec()
var reset_timer = rand_range(100, 800)

func _rand_pos():
	last_timer = OS.get_ticks_msec()
	target_pos = start_pos + Vector2(rand_range(-50,50), rand_range(-50,50))
	reset_timer = rand_range(100, 800)

func _ready():
	randomize()
	start_pos = get_global_position()
	target_pos = start_pos

func _process(delta):
	if OS.get_ticks_msec() - last_timer > reset_timer:
		_rand_pos()
	var motion
	var cur_pos = get_global_position()
	var dist = target_pos.distance_to(cur_pos)
	if dist > min_dist:
		motion = target_pos - cur_pos
	else:
		motion = Vector2(0,0)

	if motion.length() > min_dist:
		move_and_slide(motion.normalized()*speed)
	else:
		move_and_slide(Vector2(0,0))
