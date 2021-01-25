extends Control

var value1 = 0

func set_value(value):
	value1 = value
	$Label.text = str(value1)
