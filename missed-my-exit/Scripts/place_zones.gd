extends Area3D

const BOULDER_1_Scene = preload("uid://dtuf2gqqt2bwj")

var player_nearby = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var body_list = get_overlapping_bodies()
	#Checks if player is nearby
	if has_overlapping_bodies():
		for body in body_list:
			if body is Player:
				Global.NearPlaceZone = true
				player_nearby = true
				Global.PlaceZonePosition = global_position
			else: 
				Global.NearPlaceZone = false
	else: 
		Global.NearPickup = false
		player_nearby = false
		
	#Placing
	if player_nearby and Global.JustPlaced:
		Global.JustPlaced = false
		if Global.HasRock:
			var rock = BOULDER_1_Scene.instantiate()
			add_child(rock)
			Global.HasRock = false
