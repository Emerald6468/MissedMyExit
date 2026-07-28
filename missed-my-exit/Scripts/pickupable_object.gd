extends Area3D
class_name PickUp
@export var ObjectType: String

var player_nearby = false
@onready var boulder_1: Node3D = $Boulder_1
@onready var axe: Node3D = $Axe

func set_object_type(object_type):
	ObjectType = object_type

func _ready() -> void:
	boulder_1.hide()
	axe.hide()
	if ObjectType != "":
			#Have all of the different objects it can be here
			match ObjectType:
				"Rock":
					boulder_1.show()
				"Axe":
					axe.show()


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
				Global.ObjectPosition = global_position
			else: 
				if !just_nearby: player_nearby = false
		
		
	#Picking up check
	if player_nearby and Global.JustPickedUp:
		Global.JustPickedUp = false
		if ObjectType != "":
			#Have all of the different objects it can be here
			match ObjectType:
				"Rock":
					Global.HasRock = true
				"Axe":
					Global.HasAxe = true
			queue_free()
