extends Area2D


func _on_next_lvl_body_entered(body):
	if body.get_name() == "Player":
		GLOBAL.next_scene("level")