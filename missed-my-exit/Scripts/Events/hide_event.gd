@tool
extends "res://Scenes/TestScenes/Harlan/event.gd"

@export_enum("Hide", "Show", "Switch") var action: String

func _process(delta: float) -> void:
	super(delta)
	if !Engine.is_editor_hint():
		if trigger.start_next_event && !start_next_event:
			if action == "Hide":
				target.visible = false
			elif action == "Show":
				target.visible = true
			else:
				target.visible = !target.visible
			start_next_event = true
