extends CharacterBody2D

@export var speed : float = 300.0

var posToGoTo : Vector2

func _ready() -> void:
	posToGoTo = global_position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		var area := Global.view_rect().grow(-40)
		posToGoTo = get_global_mouse_position().clamp(area.position, area.end)

func _physics_process(delta: float) -> void:
	var to_target = posToGoTo - global_position
	
	if to_target.length() > 5.0:
		velocity = to_target.normalized() * speed
	else:
		velocity = Vector2.ZERO
	
	
	
	move_and_slide()
