extends Area2D

func _on_trapspike_body_entered(body):
	if body.get_name() == "Player":
		body.dead()
		yield(get_tree().create_timer(0.3), "timeout")
		GLOBAL.kill_player(body)
		GLOBAL.restart_game()
