extends Control

@onready var w: Control = $CanvasLayer/Control/W
@onready var a: Control = $CanvasLayer/Control/A
@onready var s: Control = $CanvasLayer/Control/S
@onready var d: Control = $CanvasLayer/Control/D


var w_pressed = false
var a_pressed = false
var s_pressed = false
var d_pressed = false

var all_pressed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	w.set_modulate(Color(1,1,1,1))
	a.set_modulate(Color(1,1,1,1))
	s.set_modulate(Color(1,1,1,1))
	d.set_modulate(Color(1,1,1,1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	if w_pressed and a_pressed and s_pressed and d_pressed: all_pressed = true
	
	if all_pressed: 
		Global.CurrentCheck = true
		queue_free()
		
