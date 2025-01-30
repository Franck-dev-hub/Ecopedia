extends Control

#region Variables
# Pages
@onready var option_page: Control = $"../Option page"
@onready var reset_page: Control = $"."
@onready var reset_done_page: Control = $"../Reset done page"

# Timer
@onready var timer: Timer = $"../Reset done page/Label/Timer"

#endregion

#region Menu
func _on_tout_supprimer_pressed() -> void:
	global_save.reset_save()
	timer.start()
	reset_done_page.visible = true
	reset_page.visible = false

func _on_annuler_pressed() -> void:
	option_page.visible = true
	reset_page.visible = false

#endregion
