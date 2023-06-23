extends KinematicBody2D

const gravity:int = 1000
const scene_floor:Vector2 = Vector2(0, -1)

#warning-ignore:unused_class_variable
var speed:int = 200
var alive:bool = false
#warning-ignore:unused_class_variable
var jump_power:int = 350
var floor_angle:float = deg2rad(90)
var vel:Vector2 = Vector2()
var delta:float
var gravity_vector:Vector2

enum {JUMPING, FALLING, MOVING, DEAD, IDLE}
var _state:int = IDLE

func _ready():
	$Sprite.play("vivo")
	pass # Replace with function body.

func _physics_process(delta):
	if self._state == DEAD:
		self.vel = move_and_slide(self.vel, Vector2.UP)
		return
	
	self.delta = delta
	# Delegate input
	GLOBAL.process_input(self)
	
	# Move
	# Apply gravity
	self.gravity_vector = $Pivot/GravityVector.global_transform.y.normalized()
	self.vel += self.gravity * self.delta * self.gravity_vector
	if self._state == JUMPING:
		self.vel = self.move_and_slide(self.vel, self.scene_floor)
		self.update_state(FALLING)
	else:
		self.vel = self.move_and_slide_with_snap(self.vel, Vector2(0, 32) ,self.scene_floor,true,4,0.8)
	
	# Rotate sprite depending on floor
#	self.rotate_sprite_with_floor() # DEBUG
	
	
func dead() -> void:
	self.update_state(DEAD)
	self.alive = false
	$Sprite.play("muerto")
	
func update_state(state:int) -> void:
	self._state = state
	match state:
		IDLE:
			pass
		MOVING:
			pass
		FALLING:
			pass
		JUMPING:
			pass
		FALLING:
			pass
	
func rotate_sprite_with_floor() -> void:
	var collisions = get_slide_count()
	if collisions > 0:
		var normal = get_slide_collision(0).get_normal() * -1
		var new_angle = deg2rad(round(rad2deg(normal.angle())))
		if self.floor_angle != new_angle:
			
			match new_angle:
				deg2rad(90):
					$Sprite.rotate(-self.floor_angle)
					$CollisionShape2D.rotate(-self.floor_angle)
				_:
					$Sprite.rotate(self.floor_angle+new_angle)
					$CollisionShape2D.rotate(self.floor_angle+new_angle)

			self.floor_angle = new_angle
			print(new_angle)
			$Sprite.rotation = new_angle
			
func isAlive() -> bool:
	return self.alive
	
