extends Node3D


@export var show_num: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.tutorial_num == show_num:
		show()
	elif Global.tutorial_num > show_num:
		queue_free()
