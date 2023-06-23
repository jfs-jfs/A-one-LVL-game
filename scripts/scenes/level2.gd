extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/Container/Column/Row/Iteration.text = "Iter: " + str(GLOBAL.current_level)
	$HUD/Container/Column/Row/Progress.value = GLOBAL.current_level
	$HUD/Container/Column/Row/Hint.text = GLOBAL.level_hint
	$HUD/Container/Column/InputVisualHelp.text = ""
	get_tree().paused = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	GLOBAL.process_input(self)

func update_help_label(var text:String) -> void:
	$HUD/Container/Column/InputVisualHelp.text = text
	
func update_hint_label(var text:String) -> void:
	$HUD/Container/Column/Row/Hint.text = text

func _on_StartTimer_timeout() -> void:
	get_tree().paused = false
