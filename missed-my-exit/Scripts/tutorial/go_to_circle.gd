extends Node3D

@onready var area_3d: Area3D = $Area3D

@export var show_num: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.tutorial_num == show_num:
		show()
		var body_list = area_3d.get_overlapping_bodies()
		#Checks if player is nearby
		if area_3d.has_overlapping_bodies():
			for body in body_list:
				if body is Player:
					Global.CurrentCheck = true
					queue_free()
	else: hide
