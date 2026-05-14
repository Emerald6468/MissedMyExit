extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

#Camera stuff
var mouse_sensitivity = 0.3
var timer_started = false
@onready var head: Node3D = $Head
@onready var on_foot_camera: Camera3D = $Head/OnFootCamera


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_as_top_level(true)
	

func switch_timer():
	if !timer_started:
		timer_started = true
		if Global.OnFoot: get_out_car()
		await get_tree().create_timer(.05).timeout
		timer_started = false
		Global.JustSwitched = false


func get_out_car():
	global_position = Global.PlayerMarker

func _physics_process(delta: float) -> void:
	#Switching
	if Global.JustSwitched: switch_timer()
	if Global.OnFoot:
		if !Global.JustSwitched and Input.is_action_just_pressed("SwitchControls") and Global.NearDoor:
			Global.NearDoor = false
			Global.OnFoot = false
			Global.JustSwitched = true
		#Camera
		on_foot_camera.make_current()
		
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		head.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		head.rotation_degrees.x = clampf(head.rotation_degrees.x,-45,90)
