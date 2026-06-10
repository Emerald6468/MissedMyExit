extends "res://Scripts/Events/trigger.gd"

@export var end_point: Node3D

const DEBUG_LINE = preload("res://Scenes/TestScenes/Harlan/debug_line.tscn")

var line1 = DEBUG_LINE.instantiate()
var player = null

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if end_point != null:
			line1.drawDebugLine(global_position, end_point.global_position)
		else:
			line1.clearDebugLine()

func _on_body_entered(body: Node3D) -> void:
	super(body)
	if (one_time and !start_next_event) or (!one_time):
		player.global_position = end_point.global_position
		player.rotation.y = end_point.rotation.y
