extends Node

var hint:String = "laer"

func get_player_input(var player:KinematicBody2D) -> void:
	
	var on_floor:bool = player.is_on_floor()
	
	if on_floor and Input.is_action_just_pressed("ui_down"):
		player.vel.y = - player.jump_power
		player.update_state(player.JUMPING)
	elif on_floor and Input.is_action_pressed("ui_right"):
		player.vel.x = - player.speed
	elif on_floor and Input.is_action_pressed("ui_left"):
		player.vel.x = + player.speed
	elif on_floor:
		player.vel.x = 0
		
	

func get_scene_input(var scene:Node2D) -> void:
	pass