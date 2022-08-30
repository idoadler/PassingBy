extends KinematicBody2D

export var SPEED = 250

onready var enemy = $"AnimationPlayer"

var velocity

func _ready():
	velocity = Vector2(0,0)

func _process(delta):
	
	if Input.is_action_just_released("ui_up"):
		velocity.y = 0
	if Input.is_action_just_released("ui_down"):
		velocity.y = 0
	if Input.is_action_just_released("ui_left"):
		velocity.x = 0
	if Input.is_action_just_released("ui_right"):
		velocity.x = 0

	var motion = Vector2(0,0)
	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0,-1)
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0,1)
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1,0)

	velocity += delta * motion
	velocity.x = clamp(velocity.x,-1,1)
	velocity.y = clamp(velocity.y,-1,1)

#	pos += velocity * SPEED

	move_and_slide(velocity*SPEED)
	if velocity.x == 0 && velocity.y == 0:
		enemy.play("Idle")
	else: 
		enemy.play("Walk")
		if velocity.x > 0: get_node("Face").flip_h = true 
		else: get_node("Face").flip_h = false	
	
#	var size = get_viewport_rect().size
#	var pos = get_position()
#	pos.x = clamp (pos.x,0,size.x)
#	pos.y = clamp (pos.y,0,size.y)
#	set_position(pos)
