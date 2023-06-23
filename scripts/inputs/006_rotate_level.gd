extends Node

var hint:String = "Scpace to control time"

var rotation_speed:float = 1.5
var rotation_dir:int = 1
var delta_acc:float = 0
var can_dilate_time:bool = true
var label:String = "Ready"

const MAX_PAUSE:float = 1.5
const REFILL_PAUSE:float = 1.0


func get_player_input(var player:KinematicBody2D) -> void:
	
	# Always jumping bc we dont want snapping
	player.update_state(player.JUMPING)
	
	# Get screen rotation
	if Input.is_action_pressed("ui_left"):
		self.rotation_dir = 1
	elif Input.is_action_pressed("ui_right"):
		self.rotation_dir = -1
	else:
		self.rotation_dir = 0
	
	# Get time dilation
	if self.can_dilate_time and Input.is_action_pressed("ui_select"):
		player.vel = Vector2.ZERO
		self.delta_acc += player.delta
		self.can_dilate_time = self.delta_acc < MAX_PAUSE
		self.label = "Left " + str(stepify(MAX_PAUSE - self.delta_acc, 0.1))
	elif not self.can_dilate_time:
		self.label = "Refill in " + str(stepify(REFILL_PAUSE - self.delta_acc, 0.1))
		self.delta_acc -= player.delta
		self.can_dilate_time = self.delta_acc < 0.0
	elif Input.is_action_just_released("ui_select"):
		self.can_dilate_time = false
	else:
		self.label = "Ready"

	var rot = self.rotation_dir * self.rotation_speed * player.delta
	var pivot = player.get_node("Pivot")
	pivot.rotate(rot)


func get_scene_input(var scene:Node2D) -> void:
	
	scene.update_help_label(self.label) 


