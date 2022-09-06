extends KinematicBody2D

export var speed = 250
export var radius = 300
export var min_dist = 10

onready var animation = $"AnimationPlayer"
onready var player: = get_node("/root/Node2D/Player")

var start_pos

func _ready():
	start_pos = get_global_position()

func _process(delta):
	var motion
	var target_pos = player.get_global_position()
	var cur_pos = get_global_position()
	if start_pos.distance_to(target_pos) < radius:
		if player._is_square():
			motion = Vector2(0,0)
		else:
			motion = target_pos - cur_pos
	else:
		motion = start_pos - cur_pos

	if motion.length() < min_dist:
		animation.play("Idle")
	else:
		set_global_position(cur_pos+delta*motion.normalized()*speed)
#		move_and_slide(motion.normalized()*speed)
		animation.play("Walk")
		if motion.x > 0: get_node("Face").flip_h = true 
		else: get_node("Face").flip_h = false	
