extends KinematicBody2D

export var SPEED = 250
export var exceleration = 3
export var decexeleration = 3
export(float) var animation_speed = 1.0

onready var player = $"AnimationPlayer"

var velocity

func _ready():
	velocity = Vector2(0,0)

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		player.stop(true)
		player.play("FadeToPink", 0, animation_speed)

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
	velocity.x = clamp(velocity.x,-1,1)
	velocity.y = clamp(velocity.y,-1,1)

	move_and_slide(velocity*SPEED)
	
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)

func _on_TouchScreenButton_pressed():
	player.stop(true)
	player.play("FadeToPink", 0, animation_speed)
