extends Node

const SAVE_PATH := "user://save.cfg"

var highscore: int = 0
var last_score: int = 0
var played: bool = false
var new_highscore: bool = false


func _ready() -> void:
	var file := ConfigFile.new()
	if file.load(SAVE_PATH) == OK:
		highscore = file.get_value("game", "highscore", 0)


func finish_round(score: int) -> void:
	played = true
	last_score = score
	new_highscore = score > highscore
	if new_highscore:
		highscore = score
		var file := ConfigFile.new()
		file.set_value("game", "highscore", highscore)
		file.save(SAVE_PATH)


func view_rect() -> Rect2:
	var camera := get_viewport().get_camera_2d()
	var size := get_viewport().get_visible_rect().size / camera.zoom
	return Rect2(camera.get_screen_center_position() - size / 2, size)
