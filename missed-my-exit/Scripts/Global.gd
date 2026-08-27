extends Node
#This is our global node make sure to be careful with resetting stuff

#Switching Controls
var OnFoot = true
var JustSwitched = false
var NearDoor = false

#Interactables
var NearPickup = false
var JustPickedUp = false

var HasAxe = false
var HasExtraTire = false
var HasCarJack = false
var HasPoppedTire = false
var HasItem = false
var AxeSwing = false

var NearPlaceZone = false
var JustPlaced = false

var TrunkOpened = false
var ClosestDistance = 100.0

#Flashlight
var FlashOn = false

#positions
var PlayerMarker: Vector3
var ObjectPosition: Vector3
var PlaceZonePosition: Vector3
var PlayerPosition: Vector3

#Events
var TirePopped = false

#UI and Settings
#not added to reset as they should stay even if everything else is reset
var ClosedCaptions = true
var muted = false
var volume = 50.0

#UI that will reset
var CurrentCheck = false
var tutorial_num: int = 0
var tutorial_done = false 
var in_tutorial = false

#Garage Opener
var NearGarageOpener = false
var GarageOpen = false

#make sure to add every var to reset
func reset_vars():
	OnFoot = true
	JustSwitched = false
	NearDoor = false
	NearPickup = false
	JustPickedUp = false
	HasAxe = false
	HasExtraTire = false
	AxeSwing = false
	NearPlaceZone = false
	JustPlaced = false
	HasItem = false
	TrunkOpened = false
	ClosestDistance = 100.0
	CurrentCheck = false
	tutorial_num = 0
	tutorial_done = false
	in_tutorial = false
	NearGarageOpener = false
	GarageOpen = false
	
	
