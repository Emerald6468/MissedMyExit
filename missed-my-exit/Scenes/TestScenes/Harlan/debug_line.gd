@tool
extends MeshInstance3D

func _ready() -> void:
	mesh = mesh.duplicate()

func drawDebugLine(pos1: Vector3, pos2: Vector3):
	var line = mesh
	line.clear_surfaces()
	line.surface_begin(Mesh.PRIMITIVE_LINES, StandardMaterial3D.new())
	line.surface_add_vertex(pos1)
	line.surface_add_vertex(pos2)
	line.surface_end()

func clearDebugLine():
	var line = mesh
	line.clear_surfaces()
