@tool
extends "res://Scenes/TestScenes/Harlan/event.gd"

@export var method: String

func _process(delta: float) -> void:
	super(delta)
	if !Engine.is_editor_hint():
		if trigger.start_next_event && !start_next_event:
			target.call(method)
			start_next_event = true
