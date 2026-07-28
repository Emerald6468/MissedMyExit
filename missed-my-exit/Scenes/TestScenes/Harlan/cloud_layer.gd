@tool
extends MeshInstance3D

@export var scroll_speed: float
@export_range(-180, 180, 0.1, "degrees") var scroll_angle: float

func _ready() -> void:
	mesh.material.albedo_texture.noise.offset = Vector3.ZERO

func _physics_process(delta: float) -> void:
	var dir = Vector2.from_angle(deg_to_rad(scroll_angle)).normalized() * scroll_speed
	mesh.material.albedo_texture.noise.offset += Vector3(dir.x, dir.y, 0)
