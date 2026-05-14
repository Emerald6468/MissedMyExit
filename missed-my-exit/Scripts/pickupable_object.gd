extends Area3D

var player_nearby = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var body_list = get_overlapping_bodies()
	if has_overlapping_bodies():
		for body in body_list:
			if body is Player:
				Global.NearPickup = true
				player_nearby = true
				Global.ObjectPosition = global_position
			else: 
				Global.NearPickup = false
	else: 
		Global.NearPickup = false
		player_nearby = false
	if player_nearby and Global.JustPickedUp:
		Global.JustPickedUp = false
		Global.HasRock = true
		queue_free()
