@tool
extends "res://Scenes/TestScenes/Harlan/event.gd"

@export_enum("Play", "Stop") var action: String
@export_enum("SoundStarted", "SoundFinished") var end: String

func _ready() -> void:
	super()
	target.finished.connect(_on_sound_finished)

func _process(delta: float) -> void:
	super(delta)
	if !Engine.is_editor_hint():
		if trigger.start_next_event && !start_next_event:
			if action == "Play":
				target.play()
			else:
				target.stop()
			if end == "SoundStarted":
				start_next_event = true

func _on_sound_finished():
	if end == "SoundFinished":
		start_next_event = true
