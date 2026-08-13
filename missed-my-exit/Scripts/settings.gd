extends Control

@onready var settings: CanvasLayer = $Settings
@onready var volume: HSlider = $Settings/MarginContainer/VBoxContainer/Volume
@onready var mute: CheckBox = $Settings/MarginContainer/VBoxContainer/Mute
@onready var cc: CheckBox = $Settings/MarginContainer/VBoxContainer/CC

func _ready() -> void:
	settings.visible = false
	
	#makes sure its consistant with main menu and any scene
	#volume
	volume.value = Global.volume
	AudioServer.set_bus_volume_db(0,(volume.value-50)/5)
	#mute
	mute.set_pressed(Global.muted)
	AudioServer.set_bus_mute(0,Global.muted)
	#CC
	cc.set_pressed(Global.ClosedCaptions)

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,(value-50)/5)
	Global.volume = volume.value


func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)
	Global.muted = toggled_on



func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(160,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))


func _on_exit_button_pressed() -> void:
	settings.visible = false


func _on_cc_toggled(toggled_on: bool) -> void:
	Global.ClosedCaptions = toggled_on
