extends Node

### EASY NORMAL - The user input is intuituve and it can stop middle air

var hint:String = "EASY"

func get_player_input(var player:KinematicBody2D) -> void:
	
	# Get Inputs
	if Input.is_action_just_pressed("ui_up") and player.is_on_floor():
		player.vel.y = - player.jump_power
		player.update_state(player.JUMPING)
	elif Input.is_action_pressed("ui_left"):
		player.vel.x = - player.speed
	elif Input.is_action_pressed("ui_right"):
		player.vel.x = + player.speed
	else:
		player.vel.x = 0

func get_scene_input(var scene:Node2D) -> void:
	pass
