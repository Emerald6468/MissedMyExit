extends Area3D

var start_next_event = false

func _on_body_entered(body: Node3D) -> void:
	start_next_event = true
	print("Test")

func test():
	print("Method Test")
