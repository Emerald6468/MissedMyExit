@tool
extends "res://Scenes/TestScenes/Harlan/event.gd"

@export var speed: float
@export var end_point: Node3D
@export var lerp: bool

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
			line3.clearDebugLine()
	else:
		if trigger.start_next_event == true:
			move(delta)

func move(delta: float):
	if lerp:
		target.position = target.position.lerp(end_point.position, speed)
	else:
		target.position = target.position.move_toward(end_point.position, speed * delta)
