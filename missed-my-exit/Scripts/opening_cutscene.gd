extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.OpenCutscene = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Global.OpenCutscene and !is_playing(): play("Opening Cutscene")


func _on_animation_finished(anim_name: StringName) -> void:
	Global.OpenCutscene = true
