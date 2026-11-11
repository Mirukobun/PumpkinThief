extends Node2D

@export var pumpkin_scene: PackedScene
@export var start_count: int = 3
@export var edge_margin: float = 40.0
@export var min_distance_from_player: float = 120.0

var score: int = 0

@onready var player: CharacterBody2D = $boyo
@onready var timer: Timer = $Timer
@onready var score_label: Label = $HUD/ScoreLabel
@onready var time_label: Label = $HUD/TimeLabel


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	for i in start_count:
		spawn_pumpkin()


func _process(delta: float) -> void:
	score_label.text = "Score: " + str(score)
	time_label.text = "Time: " + str(ceili(timer.time_left))


func spawn_pumpkin() -> void:
	var pumpkin = pumpkin_scene.instantiate()
	pumpkin.position = random_spot()
	pumpkin.picked_up.connect(_on_pumpkin_picked_up)
	add_child(pumpkin)


func random_spot() -> Vector2:
	var area := Global.view_rect().grow(-edge_margin)
	var spot := Vector2.ZERO
	for attempt in 20:
		spot = Vector2(
			randf_range(area.position.x, area.end.x),
			randf_range(area.position.y, area.end.y)
		)
		if spot.distance_to(player.global_position) > min_distance_from_player:
			break
	return spot


func _on_pumpkin_picked_up() -> void:
	score += 1
	spawn_pumpkin.call_deferred()


func _on_timer_timeout() -> void:
	Global.finish_round(score)
	get_tree().change_scene_to_file("res://menu.tscn")
