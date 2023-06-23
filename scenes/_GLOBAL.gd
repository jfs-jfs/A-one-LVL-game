extends CanvasLayer

export(bool) var override_controls:bool = false
export(GDScript) var override_script:GDScript
export(bool) var override_level:bool = false
export(int) var override_level_num

const INPUTS_BASE_PATH:String = "res://scripts/inputs/"
const LEVELS_BASE_PATH:String = "res://scenes/levels/level"
const SCREENS_BASE_PATH:String = "res://scenes/screens/"

const MAX_LEVEL:int = 9

const LEVELS_SCENES:Array = [
						"res://scenes/levels/level1.tscn", 
						]

var current_input_file:String = ""
var current_input_script:GDScript
var current_scene:String = "boot"
var current_level:int = -1
var inputs:Array
var scene_to_fade:Node
var input_control:Node
var level_hint:String = ""

# Load the input files
func _ready():
	# Initialize array for inputs
	for i in range(MAX_LEVEL):
		self.inputs.append(i)
	# Get the name of the input files
	var dir:Directory = Directory.new()
	var file:String = ""
	#warning-ignore:return_value_discarded
	dir.open(INPUTS_BASE_PATH)
	#warning-ignore:return_value_discarded
	dir.list_dir_begin()
	file = dir.get_next()
	while (file != ""):
		if not file.begins_with("."):
			var number = file.split("_")[0]
			self.inputs[int(number)] = file
		file = dir.get_next()
	dir.list_dir_end()
	print(self.inputs)

# SCENE CONTROLS #
func scene_fade_out(var time:float) -> Node:
	get_tree().paused = true
	return self.scene_fade(0, 1, time)

func scene_fade_in(var time:float) -> Node:
	return scene_fade(1, 0, time)

func scene_fade(var start:int, var end:int, var time:float) -> Node:
	$ColorRect.modulate = Color(0,0,0,start)
	$ColorRect.show()

	$tween.stop_all()
	$tween.interpolate_property(
					$ColorRect,
					"modulate",
					Color(0,0,0,start),
					Color(0,0,0,end),
					time,
					Tween.TRANS_LINEAR,
					Tween.EASE_IN
					)
						
	$tween.start()
	return $tween
	
func next_scene(var scene:String = "", var fade_out:float = 1, var fade_in:float = .5) -> void:
	self.current_scene = scene
	
	# Fade out old scene
	self.scene_to_fade = self.scene_fade_out(fade_out)
	yield(self.scene_to_fade, "tween_completed")
	
	# Change Scene && Controls
	if scene == "bye": # get out
		get_tree().quit()
	elif self.current_level == MAX_LEVEL - 1: # WINNER
		#warning-ignore:return_value_discarded
		get_tree().change_scene(SCREENS_BASE_PATH + "winner.tscn")
	elif scene == "level": # Level Scene
		# Update level
		self.current_level += 1
		
		# Update controls
		if not self.override_controls:
			self.current_input_file = self.inputs[self.current_level]
			self.current_input_script = load(INPUTS_BASE_PATH + self.current_input_file)
			self.input_control = self.current_input_script.new()
		else:
			self.input_control = self.override_script.new()

		# Get the hint for the level
		self.level_hint = self.input_control.hint

		# Update scene
		if not self.override_level:
			if self.current_level != MAX_LEVEL:
				#warning-ignore:return_value_discarded
				get_tree().change_scene(LEVELS_SCENES[ self.current_level % LEVELS_SCENES.size() ])
			else:
				#warning-ignore:return_value_discarded
				get_tree().change_scene(LEVELS_SCENES[0])

		else:
			#warning-ignore:return_value_discarded
			get_tree().change_scene(LEVELS_SCENES[self.override_level_num % LEVELS_SCENES.size() ])

	else: # Screen scene
		#warning-ignore:return_value_discarded
		get_tree().change_scene(SCREENS_BASE_PATH + scene + ".tscn")
		
		
	# Fade in new scene
	self.scene_to_fade = self.scene_fade_in(fade_in)
	yield(self.scene_to_fade, "tween_completed")
	
	# Clean
	$ColorRect.hide()
	get_tree().paused = false

func restart_game():
	self.current_level -= 1
	self.next_scene(self.current_scene)
# SCENE CONTROLS #

# INPUT CONTROLS #
func process_input(var object:Node2D) -> void:
	if object.get_name() == "Player":
		self.input_control.get_player_input(object)
	else:
		self.input_control.get_scene_input(object)

func load_controls(var controls_to_load:int) -> Node:
	var script = load(INPUTS_BASE_PATH + self.inputs[controls_to_load])
	return script.new()
# INPUT CONTROLS #

# PLAYER CONTROL #
func kill_player(var player:KinematicBody2D) -> void:
	player.queue_free()
# PLAYER CONTROL #
