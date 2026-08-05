@tool
extends MeshInstance3D

var line

func _ready() -> void:
	mesh = mesh.duplicate()
	line = mesh

func drawDebugLine(pos1: Vector3, pos2: Vector3):
	if Engine.is_editor_hint():
		line = mesh
		line.clear_surfaces()
		line.surface_begin(Mesh.PRIMITIVE_LINES, StandardMaterial3D.new())
		line.surface_add_vertex(pos1)
		line.surface_add_vertex(pos2)
		line.surface_end()

func clearDebugLine():
	if Engine.is_editor_hint():
		line.clear_surfaces()

func _exit_tree() -> void:
	if Engine.is_editor_hint():
		clearDebugLine()
