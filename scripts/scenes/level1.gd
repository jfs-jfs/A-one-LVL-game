extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var delta:float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	self.delta = delta
	# Delegate
	GLOBAL.process_input(self)
