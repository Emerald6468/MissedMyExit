extends Area3D
class_name PickUp
@export var ObjectType: String
@export var text_on: bool
var player_nearby = false
@onready var pickup_text: Label3D = $PickupText
@onready var axe: Node3D = $Axe
@onready var wheel: Node3D = $Wheel
@onready var car_jack: Node3D = $CarJack
@onready var popped_tire: Node3D = $PoppedTire

func set_object_type(object_type):
	ObjectType = object_type

func _ready() -> void:
	if !text_on: pickup_text.hide()
	axe.hide()
	wheel.hide()
	car_jack.hide()
	popped_tire.hide()
	if ObjectType != "":
			#Have all of the different objects it can be here
			match ObjectType:
				"Axe":
					axe.show()
				"ExtraTire":
					wheel.show()
				"CarJack":
					car_jack.show()
				"PoppedTire":
					popped_tire.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var body_list = get_overlapping_bodies()
	#Checks if player is nearby
	if has_overlapping_bodies() and Global.tutorial_num >= 5:
		var just_nearby = false
		for body in body_list:
			if body is Player:
				player_nearby = true
				just_nearby = true
				Global.ObjectPosition = global_position
			else: 
				if !just_nearby: player_nearby = false
		
		
	#Picking up check
	var stop = false
	if Global.in_tutorial:
		if Global.tutorial_num < 5: stop = true
		else: stop = false
	if player_nearby and Global.JustPickedUp and !stop:
		Global.JustPickedUp = false
		if ObjectType != "":
			#Have all of the different objects it can be here
			match ObjectType:
				"Axe":
					Global.HasAxe = true
				"ExtraTire":
					Global.HasExtraTire = true
					print("tire")
					if !Global.tutorial_done and Global.tutorial_num == 5: Global.CurrentCheck = true
				"CarJack":
					Global.HasCarJack = true
				"PoppedTire":
					Global.HasPoppedTire = true
			queue_free()
