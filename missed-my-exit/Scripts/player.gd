extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

#Camera stuff
var mouse_sensitivity = 0.3
var timer_started = false
@onready var head: Node3D = $Head
@onready var on_foot_camera: Camera3D = $Head/OnFootCamera

#Detection
@onready var nearby_check: Area3D = $NearbyCheck


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

func inventory():
	#later add all other possible items with or 
	if Global.HasRock:
		Global.HasItem = true
	else:
		Global.HasItem = false
	
func check_nearby():
	var area_list = nearby_check.get_overlapping_areas()
	#Checks if player is nearby
	if nearby_check.has_overlapping_areas():
		var just_grab_range = false
		var just_place_range = false
		for area in area_list:
			if area is PickUp:
				Global.NearPickup = true
				just_grab_range = true
			elif area is PlaceZone:
				Global.NearPlaceZone = true
				just_place_range = true
			else:
				if !just_grab_range: Global.NearPickup = false
				if !just_place_range: Global.NearPlaceZone = false
			


func _physics_process(delta: float) -> void:
	if Global.HasRock: print("HAVEROCK")
	inventory()
	check_nearby()
	#Switching
	if Global.JustSwitched: switch_timer()
	if Global.OnFoot:
		if !Global.JustSwitched and Input.is_action_just_pressed("SwitchControls") and Global.NearDoor:
			Global.NearDoor = false
			Global.OnFoot = false
			Global.JustSwitched = true
		#Camera
		on_foot_camera.make_current()
		
		#Interactables
		if Input.is_action_just_pressed("Interact"):
			if Global.NearPickup and !Global.HasItem:
				if on_foot_camera.is_position_in_frustum(Global.ObjectPosition):
					Global.JustPickedUp = true
			elif Global.NearPlaceZone and Global.HasItem:
				if on_foot_camera.is_position_in_frustum(Global.PlaceZonePosition):
					Global.JustPlaced = true	
		
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
