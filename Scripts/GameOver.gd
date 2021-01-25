extends Control

var best = GameEvent.load()
var score = 0

func _ready():
	GameEvent.connect("points_gained", self, "on_points_gained")

func on_points_gained(points):
	score += points
	$ColorRect/CenterContainer/VBoxContainer/Label.text = "Score: " + str(score)
	$ColorRect/CenterContainer/VBoxContainer/Label2.text = "Best: " + str(best)




func _on_Button_pressed():
	get_tree().reload_current_scene()


func _on_Grid_game_over():
	self.visible = true
