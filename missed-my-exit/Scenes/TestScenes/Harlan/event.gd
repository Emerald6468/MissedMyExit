@tool
extends Node3D

#@export_enum("Area", "PrevEvent") var trigger_type: int
@export var trigger: Node
@export var target: Node

const DEBUG_LINE = preload("res://Scenes/TestScenes/Harlan/debug_line.tscn")

var line1 = DEBUG_LINE.instantiate()
var line2 = DEBUG_LINE.instantiate()
var start_next_event = false

func _ready() -> void:
	if Engine.is_editor_hint():
		get_tree().root.add_child(line1)
		get_tree().root.add_child(line2)

func _process(delta: float) -> void:
	# Code to execute in editor.
	if Engine.is_editor_hint():
		if trigger != null:
			line1.drawDebugLine(trigger.global_position, global_position)
		else:
			line1.clearDebugLine()
		if target != null:
			line2.drawDebugLine(global_position, target.global_position)
		else:
			line1.clearDebugLine()
