extends Area3D

@export var one_time: bool

var start_next_event = false

func _on_body_entered(body: Node3D) -> void:
	if (one_time and !start_next_event) or (!one_time):
		start_next_event = true
	#print("TriggerTest")

func monitor_switch():
	monitoring = !monitoring
