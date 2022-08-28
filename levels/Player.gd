extends Sprite

export var SPEED = 250

var motion

func ready():
	pass

func _process(delta):
	motion = Vector2()

	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0,-1)
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0,1)
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1,0)

	var pos = get_position()
	pos += motion * delta * SPEED
	var size = get_viewport_rect().size

	pos.x = clamp (pos.x,0,size.x)
	pos.y = clamp (pos.y,0,size.y)

	set_position(pos)
