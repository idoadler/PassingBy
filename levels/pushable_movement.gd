extends CharacterBody2D

@export var speed = 250
@export var min_dist = 25

var start_pos
var target_pos
var last_timer = Time.get_ticks_msec()
var reset_timer = randf_range(100, 800)

func _rand_pos():
	last_timer = Time.get_ticks_msec()
	target_pos = start_pos + Vector2(randf_range(-50,50), randf_range(-50,50))
	reset_timer = randf_range(100, 800)

func _ready():
	randomize()
	start_pos = get_global_position()
	target_pos = start_pos

func _process(delta):
	if Time.get_ticks_msec() - last_timer > reset_timer:
		_rand_pos()
	var motion
	var cur_pos = get_global_position()
	var dist = target_pos.distance_to(cur_pos)
	if dist > min_dist:
		motion = target_pos - cur_pos
	else:
		motion = Vector2(0,0)

	if motion.length() > min_dist:
		set_velocity(motion.normalized()*speed)
		move_and_slide()
	else:
		set_velocity(Vector2(0,0))
		move_and_slide()
