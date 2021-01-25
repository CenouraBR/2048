extends Label

func _ready():
	self.visible = false
	GameEvent.connect("points_gained", self, "on_points_gained")
	
func on_points_gained(points):
	set_value(points)

func set_value(value):
	self.text = "+" + str(value)
	visible = true
	$AnimationPlayer.stop()
	$AnimationPlayer.play("SETUP")


func _on_AnimationPlayer_animation_finished(anim_name):
	self.visible = false
