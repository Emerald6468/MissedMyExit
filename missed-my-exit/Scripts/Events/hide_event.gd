@tool
extends "res://Scenes/TestScenes/Harlan/event.gd"

@export_enum("Hide", "Show", "Switch") var action: String

@export var disable: bool

func _process(delta: float) -> void:
	super(delta)
	if !Engine.is_editor_hint():
		if trigger.start_next_event && !start_next_event:
			if action == "Hide":
				target.visible = false
				if disable:
					target.set_deferred("process_mode", PROCESS_MODE_DISABLED)
			elif action == "Show":
				target.visible = true
				if disable:
					target.set_deferred("process_mode", PROCESS_MODE_INHERIT)
			else:
				target.visible = !target.visible
				if disable:
					if target.visible:
						target.set_deferred("process_mode", PROCESS_MODE_INHERIT)
					else:
						target.set_deferred("process_mode", PROCESS_MODE_DISABLED)
			start_next_event = true
