@tool
extends "res://Scenes/TestScenes/Harlan/event.gd"

@export var target: Node
@export var method: String

func _process(delta: float) -> void:
	super(delta)
	if target != null:
		if Engine.is_editor_hint():
			drawDebugLine(global_position, target.global_position)
		if method != "":
			target.call(method)
	else:
		if Engine.is_editor_hint():
			drawDebugLine(global_position, global_position)
