extends Area3D
class_name MultiPlaceZone
const BOULDER_1_Scene = preload("uid://dtuf2gqqt2bwj")
const Pickup_Scene = preload("uid://47uwttp4dh6e")

@onready var rock_spot: Marker3D = $RockSpot
@onready var axe_spot: Marker3D = $"Axe Spot"
@onready var extra_tire_spot: Marker3D = $ExtraTireSpot


#debug
@export var num: int

var player_nearby = false
var closest = false
var current_distance: float
# Called when the node enters the scene tree for the first time



#places item
func check_if_place():
	if player_nearby and Global.JustPlaced and closest and Global.TrunkOpened:
		Global.JustPlaced = false
		if Global.HasRock:
			var rock = Pickup_Scene.instantiate()
			rock.set_object_type("Rock")
			rock_spot.add_child(rock)
			rock.scale.x = .50
			rock.scale.y = .50
			rock.scale.z = .50
			Global.HasRock = false
		elif Global.HasAxe:
			var axe = Pickup_Scene.instantiate()
			axe.set_object_type("Axe")
			axe_spot.add_child(axe)
			axe.scale.x = .50
			axe.scale.y = .50
			axe.scale.z = .50
			Global.HasAxe = false
		elif Global.HasExtraTire:
			print("test3")
			var tire = Pickup_Scene.instantiate()
			tire.set_object_type("ExtraTire")
			extra_tire_spot.add_child(tire)
			tire.scale.x = .50
			tire.scale.y = .50
			tire.scale.z = .50
			Global.HasExtraTire = false
			if Global.tutorial_num == 7: Global.CurrentCheck = true


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
				current_distance = absf(global_position.distance_to(Global.PlayerPosition))
				if current_distance < Global.ClosestDistance: 
					closest = true
					Global.ClosestDistance = current_distance
					Global.PlaceZonePosition = global_position
			else:
				if !just_nearby: 
					closest = false
					player_nearby = false
		
	#Placing
	
	call_deferred("check_if_place")
