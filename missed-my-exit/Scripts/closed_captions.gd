extends Control

@onready var _dialog : RichTextLabel = $Dialog
var _typing_speed : float = 60
var _typing_time : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_text("ASDHKJASDHJKKHJASDHJK asdsdaasd asdjdasdas hello ASDdasasdasddas adsdsajjl world dsaasdasdasdads adsasdasdadsasdasd asdasdasd harlen should die")

func display_text(text : String):
	_dialog.text = text
	_dialog.visible_characters = 0
	_typing_time = 0
	while _dialog.visible_characters < _dialog.get_total_character_count():
		_typing_time += get_process_delta_time()
		_dialog.visible_characters = _typing_speed * _typing_time as int
		await get_tree().process_frame
