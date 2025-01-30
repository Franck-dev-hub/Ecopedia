extends Control

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
