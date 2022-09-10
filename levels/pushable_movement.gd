extends KinematicBody2D

export var speed = 250
export var min_dist = 25

onready var animation = $"AnimationPlayer"

var start_pos

func _ready():
	start_pos = get_global_position()

func _process(delta):
	var motion
	var cur_pos = get_global_position()
	var dist = start_pos.distance_to(cur_pos)
	if dist > min_dist:
		motion = start_pos - cur_pos
	else:
		motion = Vector2(0,0)

	if motion.length() > min_dist:
		move_and_slide(motion.normalized()*speed)
	else:
		move_and_slide(Vector2(0,0))
