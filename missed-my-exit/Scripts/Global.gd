extends Node
#This is our global node make sure to be careful with resetting stuff

#Switching Controls
var OnFoot = false
var JustSwitched = false
var PlayerMarker:Vector3

#make sure to add every var to reset
func reset_vars():
	OnFoot = true
	JustSwitched = false
	
