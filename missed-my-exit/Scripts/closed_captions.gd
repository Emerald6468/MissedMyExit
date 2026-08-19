extends Control

@onready var _dialog : RichTextLabel = $Dialog
@onready var tutorial: RichTextLabel = $Tutorial

var _typing_speed : float = 60
var _typing_time : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#display_text(_dialog,"ASDHKJASDHJKKHJASDHJK asdsdaasd asdjdasdas hello ASDdasasdasddas adsdsajjl world dsaasdasdasdads adsasdasdadsasdasd asdasdasd harlen should live :D")
	#display_text(tutorial,"WASD TO MOVE")
	pass

#Tutorial
#
#WASD TO MOVE
#
#MOve Mouse to look around
#
#Walk to car trunk 
#
#E to interact
#
#Find Extra Wheel
#
#E to pick up
#
#Store extra wheel 
#
#E to place
#
#Open garage
#
#Get in Car
#
#F to Get enter and exit car
#
#E to toggle headlights
#
#W to go forward
#A to turn left 
#D to turn right
#S to reverse
#
#Leave Garage

func display_text(type: RichTextLabel, text : String):
	type.text = text
	type.visible_characters = 0
	_typing_time = 0
	while type.visible_characters < type.get_total_character_count():
		_typing_time += get_process_delta_time()
		type.visible_characters = _typing_speed * _typing_time as int
		await get_tree().process_frame
		
func _process(delta: float) -> void:
	if !Global.ClosedCaptions: visible = false
	else: visible = true
