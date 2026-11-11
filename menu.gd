extends Control

@onready var title: Label = $Center/Box/Title
@onready var result: Label = $Center/Box/Result
@onready var highscore: Label = $Center/Box/Highscore
@onready var start_button: Button = $Center/Box/StartButton
@onready var quit_button: Button = $Center/Box/QuitButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	highscore.text = "Highscore: " + str(Global.highscore)
	result.hide()

	if Global.played:
		title.text = "Time's up!"
		result.text = "Score: " + str(Global.last_score)
		result.show()
		start_button.text = "Try again"
		if Global.new_highscore:
			highscore.text = "New highscore: " + str(Global.highscore)
			highscore.add_theme_color_override("font_color", Color.RED)


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://points.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
