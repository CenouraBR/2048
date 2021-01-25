extends Label

var total_points = 0

func _process(delta):
	total_points = GameEvent.load()
	self.text = str(total_points)
