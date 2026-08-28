extends Area3D

var player_nearby = false
const pop_wheel_scene = preload("uid://47uwttp4dh6e")

var hold_time = 0
var hold_max = 20

var bolts_off = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if hold_time <= hold_max:
		if player_nearby and Input.is_action_pressed("Interact") and Global.JackUp:
			print("yazo")
			hold_time += 1
	else: bolts_off = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var body_list = get_overlapping_bodies()
	#Checks if player is nearby
	if has_overlapping_bodies():
		var just_nearby = false
		for body in body_list:
			if body is Player:
				player_nearby = true
				just_nearby = true
			else:
				if !just_nearby:
					player_nearby = false
	if bolts_off:
			var pop = pop_wheel_scene.instantiate()
			add_sibling(pop)
			pop.global_position = global_position
			pop.set_object_type("PoppedTire")
			#jack.scale.x = .50
			#jack.scale.y = .50
			#jack.scale.z = .50
			print("yahooo")
			Global.TireEmpty = true
			queue_free()
