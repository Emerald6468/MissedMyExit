extends Control

@onready var button_box: VBoxContainer = %ButtonBox
#@onready var credits: Control = $CanvasLayer/Credits

func _ready() -> void:
	get_tree().paused = false
	#focus_button()
	#credits.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE



func _on_quit_button_pressed() -> void:
	#$AudioStreamPlayer2.play()
	get_tree().quit()

func _on_visibility_changes() -> void:
	if visible:
		focus_button()

func focus_button() -> void:
	if button_box:
		var button:Button = button_box.get_child(0)
		if button is Button:
			button.grab_focus()
			


func _on_start_button_pressed() -> void:
	#$AudioStreamPlayer2.play()
	get_tree().change_scene_to_file("res://Scenes/TestScenes/Harlan/cloud_test.tscn")
