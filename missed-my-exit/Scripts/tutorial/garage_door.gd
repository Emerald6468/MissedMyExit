extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var opened = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.tutorial_done = false
	Global.tutorial_num = 0
	opened = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.GarageOpen and !opened and Global.tutorial_num == 8:
		opened = true
		animation_player.play("OpenDoor")
		Global.CurrentCheck = true
	if Global.tutorial_done: 
		print("test2")
		Global.FlashOn = true
		get_tree().change_scene_to_file("res://Scenes/TestScenes/LoopTest3.tscn")
