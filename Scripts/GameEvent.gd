extends Node

signal points_gained(amount)
	
func save(points):
	var file = File.new()
	file.open("res://Scripts/save.dat", File.WRITE)
	file.store_string(str(points))
	file.close()
	
func load():
	var file = File.new()
	file.open("res://Scripts/save.dat", File.READ)
	var points = file.get_as_text()
	file.close()
	return int(points)
