extends Node

const MAX_STACKS:int = 10
enum {UP, LEFT, RIGHT}

var stacks:int = 0
var lastInput:int = -1

var modified:bool = false

var hint:String = "Stack! Stack! Stack!"

func get_player_input(var player:KinematicBody2D) -> void:
	
	
	if Input.is_action_just_pressed("ui_up") and player.is_on_floor():
		self.stacks = self.stacks + 1 if (self.lastInput == UP and self.stacks < MAX_STACKS) else 1
		self.lastInput = UP
		self.modified = true
	elif Input.is_action_just_pressed("ui_left"):
		self.stacks = self.stacks + 1 if (self.lastInput == LEFT and self.stacks < MAX_STACKS) else 1
		self.lastInput = LEFT
		self.modified = true
	elif Input.is_action_just_pressed("ui_right"):
		self.stacks = self.stacks + 1 if (self.lastInput == RIGHT and self.stacks < MAX_STACKS) else 1
		self.lastInput = RIGHT
		self.modified = true
	elif Input.is_action_just_pressed("ui_select"):
		match self.lastInput:
			UP:
				player.vel.y = - player.jump_power * self.stacks/2
				player.update_state(player.JUMPING)
			LEFT:
				player.vel.x -= player.speed * self.stacks * 2
			RIGHT:
				player.vel.x += player.speed * self.stacks * 2

	else:
		player.vel.x = 0


func get_scene_input(var scene:Node2D) -> void:
	if self.modified:
		scene.update_help_label(str(self.stacks))
		self.modified = false

