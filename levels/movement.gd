extends CharacterBody2D

const FADE_ANIM = "FadeToPink"

@export var speed = 250
@export var exceleration = 3
@export var decexeleration = 3
@export var animation_speed: float = 1.0

@onready var body_anim = $"AnimationPlayer"
@onready var face_anim = $"AnimationPlayer2"

var movement

func _ready():
	movement = Vector2(0,0)

func _is_square():
	if body_anim.get_current_animation() != FADE_ANIM:
		return false
	return body_anim.get_current_animation_position() / body_anim.get_current_animation_length() < 0.5

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		body_anim.stop(true)
		body_anim.play(FADE_ANIM, 0, animation_speed)

	var motion = Vector2(0,0)
	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0,-1) * exceleration * delta
	elif Input.is_action_pressed("ui_down"):
		motion += Vector2(0,1) * exceleration * delta
	elif movement.y > decexeleration * delta:
		motion.y -= decexeleration * delta
	elif movement.y < -decexeleration * delta:
		motion.y += decexeleration * delta
	else:
		movement.y = 0
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1,0) * exceleration * delta
	elif Input.is_action_pressed("ui_right"):
		motion += Vector2(1,0) * exceleration * delta
	elif movement.x > decexeleration * delta:
		motion.x -= decexeleration * delta
	elif movement.x < -decexeleration * delta:
		motion.x += decexeleration * delta
	else:
		movement.x = 0

	movement += motion 

	if movement.length() < 0.01:
		face_anim.play("Idle")
		set_velocity(Vector2(0,0))
		move_and_slide()
	else:
		if movement.length() > 1:
			movement = movement.normalized()
		set_velocity(movement*speed)
		move_and_slide()
		face_anim.play("Walk")
		if movement.x > 0: get_node("Face").flip_h = true 
		else: get_node("Face").flip_h = false	
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)

func disguise():
	body_anim.stop(true)
	body_anim.play("FadeToPink", 0, animation_speed)
