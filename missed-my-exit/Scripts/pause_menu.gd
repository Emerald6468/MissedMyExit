extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var paused = false
var one_time = false
var just_paused = false

func _ready() -> void:
	paused = false
	get_tree().paused = false
	animation_player.play("RESET")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Escape") and !one_time:
		one_time = true
		print("test")
		paused = !paused
		if paused: just_paused = true
	if Input.is_action_just_released("Escape"): one_time = false
	if paused:
		if just_paused:
			animation_player.play("FadeIn")
			just_paused = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
	else: 
		print("unpause")
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		animation_player.play("RESET")
		get_tree().paused = false


#interacting from other scripts
func get_paused():
	return paused

func set_paused(Paused: bool):
	paused = Paused

func _on_resume_button_pressed() -> void:
	paused = false
	


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")
