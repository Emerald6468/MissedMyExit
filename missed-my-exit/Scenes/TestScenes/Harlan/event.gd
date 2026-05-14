@tool
extends Node3D

@export_enum("Area", "PrevEvent") var trigger_type: int
@export var trigger: Node3D

var mesh = MeshInstance3D.new()
var line = ImmediateMesh.new()
var finished = false

func _ready() -> void:
	if Engine.is_editor_hint():
		mesh.mesh = line
		mesh.name = "Debug_Line"
		get_tree().root.add_child(mesh)

func _process(delta: float) -> void:
	# Code to execute in editor.
	if Engine.is_editor_hint():
		if trigger != null:
			drawDebugLine(global_position, trigger.global_position)
		else:
			drawDebugLine(global_position, global_position)

func drawDebugLine(pos1: Vector3, pos2: Vector3):
	var line = mesh.mesh
	line.clear_surfaces()
	line.surface_begin(Mesh.PRIMITIVE_LINES, StandardMaterial3D.new())
	line.surface_add_vertex(pos1)
	line.surface_add_vertex(pos2)
	line.surface_end()
