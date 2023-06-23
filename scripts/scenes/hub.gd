extends Node2D

const OPTIONS:Array = [ "level", "controls", "bye" ]
export(Color) var SELECT_COLOR:Color =  Color.lemonchiffon
export(Color) var UNSELECT_COLOR:Color = Color(244, 244, 244)

var selected_index:int = 0

func _ready():
	yield(get_tree().create_timer(.5), "timeout")
	self.update_label_selected()


#warning-ignore:unused_argument
func _physics_process(var delta:float) -> void:
	
	var change:bool = false
	
	if Input.is_action_just_pressed("ui_accept"):
		GLOBAL.next_scene(OPTIONS[self.selected_index])
	elif Input.is_action_just_pressed("ui_down"):
		change = true
		self.selected_index += 1
		self.selected_index %= OPTIONS.size()
	elif Input.is_action_just_pressed("ui_up"):
		change = true
		self.selected_index -= 1
		self.selected_index %= OPTIONS.size()
		
	if change:
		self.update_label_selected()

func update_label_selected() -> void:
	
	match OPTIONS[self.selected_index]:
		"level":
			$MarginContainer/HBoxContainer/VBoxContainer/Start.add_color_override("font_color", SELECT_COLOR)
			$MarginContainer/HBoxContainer/VBoxContainer/Controls.add_color_override("font_color", UNSELECT_COLOR)
			$MarginContainer/HBoxContainer/VBoxContainer/Exit.add_color_override("font_color", UNSELECT_COLOR)
		"controls":
			$MarginContainer/HBoxContainer/VBoxContainer/Controls.add_color_override("font_color", SELECT_COLOR)
			$MarginContainer/HBoxContainer/VBoxContainer/Exit.add_color_override("font_color", UNSELECT_COLOR)
			$MarginContainer/HBoxContainer/VBoxContainer/Start.add_color_override("font_color", UNSELECT_COLOR)
			
		"bye":
			$MarginContainer/HBoxContainer/VBoxContainer/Exit.add_color_override("font_color", SELECT_COLOR)
			$MarginContainer/HBoxContainer/VBoxContainer/Controls.add_color_override("font_color", UNSELECT_COLOR)
			$MarginContainer/HBoxContainer/VBoxContainer/Start.add_color_override("font_color", UNSELECT_COLOR)
