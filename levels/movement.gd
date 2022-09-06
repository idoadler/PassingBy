extends KinematicBody2D

const FADE_ANIM = "FadeToPink"

export var speed = 250
export var exceleration = 3
export var decexeleration = 3
export(float) var animation_speed = 1.0

onready var body_anim = $"AnimationPlayer"
onready var face_anim = $"AnimationPlayer2"

var velocity

func _ready():
	velocity = Vector2(0,0)

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
	elif velocity.y > decexeleration * delta:
		motion.y -= decexeleration * delta
	elif velocity.y < -decexeleration * delta:
		motion.y += decexeleration * delta
	else:
		velocity.y = 0
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1,0) * exceleration * delta
	elif Input.is_action_pressed("ui_right"):
		motion += Vector2(1,0) * exceleration * delta
	elif velocity.x > decexeleration * delta:
		motion.x -= decexeleration * delta
	elif velocity.x < -decexeleration * delta:
		motion.x += decexeleration * delta
	else:
		velocity.x = 0

	velocity += motion 

	if velocity.length() < 0.01:
		face_anim.play("Idle")
		move_and_slide(Vector2(0,0))
	else:
		if velocity.length() > 1:
			velocity = velocity.normalized()
		move_and_slide(velocity*speed)	
		face_anim.play("Walk")
		if velocity.x > 0: get_node("Face").flip_h = true 
		else: get_node("Face").flip_h = false	
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)

func _on_TouchScreenButton_pressed():
	body_anim.stop(true)
	body_anim.play("FadeToPink", 0, animation_speed)
