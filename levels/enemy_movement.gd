extends KinematicBody2D

export var speed = 250
export var radius = 300

onready var animation = $"AnimationPlayer"
onready var player: = get_node("/root/Node2D/Player")

var velocity

func _ready():
	velocity = Vector2(0,0)

func _process(delta):
	var motion = Vector2(0,0)
	print(str(get_global_position().distance_to(player.get_global_position())))
	if get_global_position().distance_to(player.get_global_position()) < radius:
		if get_global_position().y > player.get_global_position().y:
			motion += Vector2(0,-1)
		if get_global_position().y < player.get_global_position().y:
			motion += Vector2(0,1)
		if get_global_position().x > player.get_global_position().x:
			motion += Vector2(-1,0)
		if get_global_position().x < player.get_global_position().x:
			motion += Vector2(1,0)

	velocity = motion
	velocity.x = clamp(velocity.x,-1,1)
	velocity.y = clamp(velocity.y,-1,1)

	move_and_slide(velocity*speed)
	if velocity.x == 0 && velocity.y == 0:
		animation.play("Idle")
	else: 
		animation.play("Walk")
		if velocity.x > 0: get_node("Face").flip_h = true 
		else: get_node("Face").flip_h = false	
