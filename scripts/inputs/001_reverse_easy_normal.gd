extends Node

### REVERSE EASY NORMAL - Same as easy normal but with inversed controls

var hint:String = "YSAE"

func get_player_input(var player:KinematicBody2D) -> void:
	
	if Input.is_action_just_pressed("ui_down") and player.is_on_floor():
		player.vel.y = - player.jump_power
		player.update_state(player.JUMPING)
	elif Input.is_action_pressed("ui_right"):
		player.vel.x = - player.speed
	elif Input.is_action_pressed("ui_left"):
		player.vel.x = + player.speed
	else:
		player.vel.x = 0
		
	

func get_scene_input(var scene:Node2D) -> void:
	pass
	
