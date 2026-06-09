@tool
extends "res://Scenes/TestScenes/Harlan/event.gd"

@export var speed: float
@export var end_point: Node3D
@export var lerp: bool
@export var teleport: bool

var line3 = DEBUG_LINE.instantiate()

func _ready() -> void:
	super()
	if Engine.is_editor_hint():
		get_tree().root.add_child(line3)

func _process(delta: float) -> void:
	super(delta)
	if Engine.is_editor_hint():
		if end_point != null && target != null:
			line3.drawDebugLine(target.global_position, end_point.global_position)
		else:
			line3.drawDebugLine(global_position, global_position)
	else:
		if trigger.start_next_event && !start_next_event:
			move(delta)

func move(delta: float):
	if lerp:
		target.global_position = target.global_position.lerp(end_point.global_position, speed)
	elif teleport:
		target.global_position = end_point.global_position
	else:
		target.global_position = target.global_position.move_toward(end_point.global_position, speed * delta)
	if target.global_position.distance_to(end_point.global_position) <= speed:
		print("test3")
		start_next_event = true
