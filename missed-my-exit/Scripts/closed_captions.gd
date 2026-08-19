extends Control

@onready var _dialog : RichTextLabel = $Dialog
@onready var tutorial: RichTextLabel = $Tutorial

var _typing_speed : float = 60
var _typing_time : float

var just_changed = true
var tutorial_done = false
var tutorial_num = 0
var tutorial_text: Array = [
	"WASD TO MOVE",
	"Move Mouse to look around",
	"Walk to car trunk",
	"E to interact",
	"Find Extra Wheel",
	"E to pick up",
	"Store extra wheel",
	"E to place",
	"Open garage door",
	"Get in Car",
	"F to Get enter and exit car",
	"E to toggle headlights",
	"W to go forward",
	"A to turn left ",
	"D to turn right",
	"S to reverse",
	"Leave Garage",
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#display_text(_dialog,"ASDHKJASDHJKKHJASDHJK asdsdaasd asdjdasdas hello ASDdasasdasddas adsdsajjl world dsaasdasdasdads adsasdasdadsasdasd asdasdasd harlen should live :D")
	#display_text(tutorial,"WASD TO MOVE")
	pass

func display_text(type: RichTextLabel, text : String):
	type.text = text
	type.visible_characters = 0
	_typing_time = 0
	while type.visible_characters < type.get_total_character_count():
		_typing_time += get_process_delta_time()
		type.visible_characters = _typing_speed * _typing_time as int
		await get_tree().process_frame
		


#temp var
var temp = false
var check = false
func run_tutorial():
	if Global.CurrentCheck:
		Global.CurrentCheck = false
		temp = true
	if just_changed:
		just_changed = false
		display_text(tutorial,tutorial_text[tutorial_num])
	match tutorial_num:
		0: 
			if temp: check = true
		1: 
			if temp: check = true
		2: 
			if temp: check = true
		3: 
			if temp: check = true
		4: 
			if temp: check = true
		5: 
			if temp: check = true
		6: 
			if temp: check = true
		7: 
			if temp: check = true
		8: 
			if temp: check = true
		9: 
			if temp: check = true
		10: 
			if temp: check = true
		11: 
			if temp: check = true
		12: 
			if temp: check = true
		13: 
			if temp: check = true
		14: 
			if temp: check = true
		15: 
			if temp: check = true
		16:
			if temp: check = true
	
	if check:
		check = false
		var last_item = tutorial_num >= tutorial_text.size()-1
		if !last_item: tutorial_num += 1
		else: tutorial_done = true
		just_changed = true
	if temp: temp = false

func _process(delta: float) -> void:
	if !Global.ClosedCaptions: visible = false
	else: visible = true
	if Input.is_action_just_pressed("Next"):
		temp = true
	if !tutorial_done:run_tutorial()
	else: tutorial.clear()
