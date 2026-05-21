extends Area3D
class_name PlaceZone
const BOULDER_1_Scene = preload("uid://dtuf2gqqt2bwj")
@onready var debug: MeshInstance3D = $debug

var player_nearby = false
var closest = false
var current_distance: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	debug.hide()

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
				#Only works for the closest rock
				current_distance = global_position.distance_to(Global.PlayerPosition)
				if current_distance < Global.ClosestDistance: 
					closest = true
					Global.ClosestDistance = current_distance
					Global.PlaceZonePosition = global_position
			else:
				if !just_nearby: player_nearby = false
		
	#Placing
	if current_distance != Global.ClosestDistance: closest = false
	if closest: debug.show()
	else: debug.hide()
	if player_nearby and Global.JustPlaced:
		Global.JustPlaced = false
		if Global.HasRock:
			var rock = BOULDER_1_Scene.instantiate()
			add_child(rock)
			Global.HasRock = false
