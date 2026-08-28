extends Node3D

const PICKUPABLE_OBJECT_SCENE = preload("uid://47uwttp4dh6e")

@onready var area: Area3D = $Area3D

var hold_time = 0
var hold_max = 20

var player_nearby = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event):
	if hold_time <= hold_max:
		if player_nearby and Input.is_action_pressed("Interact"):
			hold_time += 1
	else: Global.JackUp = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var body_list = area.get_overlapping_bodies()
		#Checks if player is nearby
	if area.has_overlapping_bodies():
		var just_nearby = false
		for body in body_list:
			if body is Player:
				player_nearby = true
				just_nearby = true
			else:
				if !just_nearby:
					player_nearby = false
		#if Input.action_press("Interact") and player_nearby:
			#hold_time += 1
	#when you fix it
	if !Global.TirePopped:
		var jack = PICKUPABLE_OBJECT_SCENE.instantiate()
		add_sibling(jack)
		jack.set_object_type("CarJack")
		jack.global_position = global_position
		#jack.scale.x = .50
		#jack.scale.y = .50
		#jack.scale.z = .50
		Global.HasCarJack = false
		queue_free()
