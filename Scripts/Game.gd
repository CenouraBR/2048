extends Control

func _ready():
	$GameOver.visible = false

func _on_Button_pressed():
	get_tree().reload_current_scene()
