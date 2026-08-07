extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var paused = false
var one_time = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Escape") and !one_time:
		one_time = true
		paused = !paused
	if Input.is_action_just_released("Escape"): queue_
	if paused:
		visible = true
		animation_player.play("FadeIn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
	else: 
		visible = false
		get_tree().paused = false


#interacting from other scripts
func get_paused():
	return paused

func set_paused(Paused: bool):
	paused = Paused

func _on_resume_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TestScenes/Harlan/cloud_test.tscn")
