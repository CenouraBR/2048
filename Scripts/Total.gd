extends Label

var total = 0

func _ready():
	GameEvent.connect("points_gained", self, "on_points_gained")

func on_points_gained(points):
	total += points
	self.text = str(total)
	if total > GameEvent.load():
		GameEvent.save(total)
	
