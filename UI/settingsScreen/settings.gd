extends Control

export(Array, Resource) var options : Array

func _ready() -> void:
	for option in options:
		print(option.type)
