extends CharacterBody2D

@export var speed = 250
@export var radius = 300
@export var min_dist = 25
@export var player_radius = 165

@onready var animation = $"AnimationPlayer"
@onready var player: = $"%Player"

var start_pos

func _ready():
	start_pos = get_global_position()

func _process(delta):
	var motion
	var target_pos = player.get_global_position()
	var cur_pos = get_global_position()
	var player_dist = start_pos.distance_to(target_pos)
	if player_dist < radius and cur_pos.distance_to(target_pos) > player_radius and not player._is_square():
		motion = target_pos - cur_pos
	elif player_dist > radius + min_dist:
		motion = start_pos - cur_pos
	else:
		motion = Vector2(0,0)

	if motion.length() < min_dist:
		animation.play("Idle")
	else:
		set_global_position(cur_pos+delta*motion.normalized()*speed)
		set_velocity(motion.normalized()*speed)
		move_and_slide()
#		velocity
		animation.play("Walk")
		if motion.x > 0: get_node("Face").flip_h = true 
		else: get_node("Face").flip_h = false	
