extends Area3D

var start_next_event = false
var test = false

func _on_body_entered(body: Node3D) -> void:
	start_next_event = true
	print("Test")
