extends Node

var loop1
var loop2
var loop3
var loop4
var loop5
var loop6
var car

func _ready() -> void:
	var root = get_tree().current_scene
	loop1 = root.get_node("Loop1")
	loop2 = root.get_node("Loop2")
	loop3 = root.get_node("Loop3")
	loop4 = root.get_node("Loop4")
	loop5 = root.get_node("Loop5")
	loop6 = root.get_node("Loop6")
	car = root.get_node("FinalCar")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dev_two"):
		loop1.visible = true
		loop2.visible = true
		car.global_position = Vector3(loop2.global_position.x, loop2.global_position.y + 5, loop2.global_position.z)
	elif Input.is_action_just_pressed("dev_three"):
		loop2.visible = true
		loop3.visible = true
		car.global_position = Vector3(loop3.global_position.x, loop3.global_position.y + 5, loop3.global_position.z)
	elif Input.is_action_just_pressed("dev_four"):
		loop3.visible = true
		loop4.visible = true
		car.global_position = Vector3(loop4.global_position.x, loop4.global_position.y + 5, loop4.global_position.z)
	elif Input.is_action_just_pressed("dev_five"):
		loop4.visible = true
		loop5.visible = true
		car.global_position = Vector3(loop5.global_position.x, loop5.global_position.y + 5, loop5.global_position.z)
	elif Input.is_action_just_pressed("dev_six"):
		loop5.visible = true
		loop6.visible = true
		car.global_position = Vector3(loop6.global_position.x, loop6.global_position.y + 5, loop6.global_position.z)
