extends Node2D

@onready var hub: Camera2D = $Cameras/HUB
@onready var option: Camera2D = $Cameras/HUB/MarginContainer/HBoxContainer/V_Places/Option/Option

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_option_pressed() -> void:
	if option.enabled:
		option.enabled = false
		hub.enabled = true
	elif not option.enabled:
		option.enabled = true
		hub.enabled = false
