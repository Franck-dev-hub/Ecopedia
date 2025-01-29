extends Control

#region Variables
@onready var main_page: Control = $"../Main page"
@onready var option_page: Control = $"."
@onready var reset_page: Control = $"../Reset page"

#endregion

#region Menu
func _on_reset_save_pressed() -> void:
	reset_page.visible = true
	option_page.visible = false

func _on_home_pressed() -> void:
	main_page.visible = true
	option_page.visible = false

#endregion
