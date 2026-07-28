extends Node3D

var player_nearby = false
@onready var area: Area3D = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
				Global.ObjectPosition = global_position
			else: 
				if !just_nearby: player_nearby = false
	if player_nearby and Global.HasAxe and Global.AxeSwing:
		print("Test2")
		queue_free()
