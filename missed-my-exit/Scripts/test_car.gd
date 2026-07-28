extends VehicleBody3D

@export var MAX_STEER = 0.9
@export var ENGINE_POWER = 300

func _physics_process(delta):
	#10 is how fast it switches to new value so the delay if we wanna add that
	steering = move_toward(steering, Input.get_axis("Right","Left") * MAX_STEER, delta * 10)
	engine_force = Input.get_axis("Backward","Forward") * ENGINE_POWER
