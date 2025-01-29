extends Control

# Pages
@onready var reset_done_page: Control = $"."
@onready var option_page: Control = $"../Option page"

func _on_timer_timeout() -> void:
	option_page.visible = true
	reset_done_page.visible = false
