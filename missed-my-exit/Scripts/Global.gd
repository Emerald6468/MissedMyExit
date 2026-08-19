extends Node
#This is our global node make sure to be careful with resetting stuff

#Switching Controls
var OnFoot = false
var JustSwitched = false
var NearDoor = false

#Interactables
var NearPickup = false
var JustPickedUp = false
var HasRock = false
var HasAxe = false
var AxeSwing = false
var NearPlaceZone = false
var JustPlaced = false
var HasItem = false
var ClosestDistance = 100.0

#positions
var PlayerMarker: Vector3
var ObjectPosition: Vector3
var PlaceZonePosition: Vector3
var PlayerPosition: Vector3

#UI and Settings
#not added to reset as they should stay even if everything else is reset
var ClosedCaptions = true
var muted = false
var volume = 50.0

#UI that will reset
var CurrentCheck = false
var tutorial_num: int = 0
#make sure to add every var to reset
func reset_vars():
	OnFoot = false
	JustSwitched = false
	NearDoor = false
	NearPickup = false
	JustPickedUp = false
	HasAxe = false
	AxeSwing = false
	NearPlaceZone = false
	JustPlaced = false
	HasItem = false
	ClosestDistance = 100.0
	CurrentCheck = false
	tutorial_num = 0
	#temp ones prob delete later
	HasRock = false
	
	
