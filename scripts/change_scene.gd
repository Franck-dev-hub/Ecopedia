extends Node

@export_file("*.tscn") var scene_path: String

func _on_pressed() -> void:
	get_tree().change_scene_to_file(scene_path)
