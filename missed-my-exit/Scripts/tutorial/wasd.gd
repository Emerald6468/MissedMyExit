extends Control
@onready var can: CanvasLayer = $CanvasLayer

@onready var w: Control = $CanvasLayer/Control/W
@onready var a: Control = $CanvasLayer/Control/A
@onready var s: Control = $CanvasLayer/Control/S
@onready var d: Control = $CanvasLayer/Control/D

@onready var d1: Label = $CanvasLayer/Control/W/Description
@onready var d2: Label = $CanvasLayer/Control/A/Description
@onready var d3: Label = $CanvasLayer/Control/S/Description
@onready var d4: Label = $CanvasLayer/Control/D/Description

var w_pressed = false
var a_pressed = false
var s_pressed = false
var d_pressed = false

var all_pressed = false
var newstart = false

var one_time = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.tutorial_done: queue_free()
	mod()
	d1.hide()
	d2.hide()
	d3.hide()
	d4.hide()
	

func mod():
	w.set_modulate(Color(1,1,1,1))
	a.set_modulate(Color(1,1,1,1))
	s.set_modulate(Color(1,1,1,1))
	d.set_modulate(Color(1,1,1,1))

func set_false():
	w_pressed = false
	a_pressed = false
	s_pressed = false
	d_pressed = false

	all_pressed = false

func check_tutorial():
	if (Global.tutorial_num == 0 or Global.tutorial_num == 10) and newstart:
		mod()
		newstart = false
		can.show()
		if Global.tutorial_num == 10:
			d1.show()
			d2.show()
			d3.show()
			d4.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.tutorial_done: queue_free()
	check_tutorial()
	#call_deferred("check_tutorial")
	if Input.is_action_just_pressed("Forward"): 
		w_pressed = true
		w.set_modulate(Color(1,1,1,.6))
	if Input.is_action_just_pressed("Left"): 
		a_pressed = true
		a.set_modulate(Color(1,1,1,.6))
	if Input.is_action_just_pressed("Backward"): 
		s_pressed = true
		s.set_modulate(Color(1,1,1,.6))
	if Input.is_action_just_pressed("Right"): 
		d_pressed = true
		d.set_modulate(Color(1,1,1,.6))
	if w_pressed and a_pressed and s_pressed and d_pressed: 
		all_pressed = true
		one_time = true
	
	if all_pressed and one_time:
		newstart = true
		one_time = false
		set_false()
		Global.CurrentCheck = true
		can.hide()
		
