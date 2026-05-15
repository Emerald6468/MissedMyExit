@tool
extends "res://Scenes/TestScenes/Harlan/event.gd"

@export var method: String

func _process(delta: float) -> void:
	super(delta)
	if target != null:
		if method != "":
			target.call(method)
