extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(var delta:float) -> void:
	
	if Input.is_action_just_pressed("ui_select"):
		GLOBAL.next_scene("hub")
