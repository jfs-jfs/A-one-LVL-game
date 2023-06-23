extends Node

var hint:String = "Edilssssss"

func get_player_input(var player:KinematicBody2D) -> void:
	
	if Input.is_action_just_pressed("ui_down") and player.is_on_floor():
		player.vel.y = - player.jump_power
		player.update_state(player.JUMPING)
	elif Input.is_action_pressed("ui_right"):
		player.vel.x = - player.speed
	elif Input.is_action_pressed("ui_left"):
		player.vel.x = + player.speed


func get_scene_input(var scene:Node2D) -> void:
	pass

