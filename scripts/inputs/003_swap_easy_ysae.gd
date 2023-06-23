extends Node

var SCRIPTS:Array 
const SWITCH_TIME:float = 3.0

var hint:String = ""
var delta_acc:float = 0.0
var current_script_index = 0
var switched:bool = true

func _init():
	SCRIPTS.append(GLOBAL.load_controls(000))
	SCRIPTS.append(GLOBAL.load_controls(001))


func get_player_input(var player:KinematicBody2D) -> void:
	self.delta_acc += player.delta
	
	SCRIPTS[self.current_script_index].get_player_input(player)
	
	if self.delta_acc > SWITCH_TIME:
		self.switched = true
		self.delta_acc = 0
		self.current_script_index += 1
		self.current_script_index = self.current_script_index % SCRIPTS.size()
	

func get_scene_input(var scene:Node2D) -> void:
	if self.switched:
		self.switched = false
		scene.update_hint_label(SCRIPTS[self.current_script_index].hint)
		
	scene.update_help_label(str(round(SWITCH_TIME - self.delta_acc)))
