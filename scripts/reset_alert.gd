extends Popup

@onready var reset_alert: Popup = $"."
@onready var hub: Camera2D = $"../../../../.."
@onready var option: Camera2D = $"../Option"

func _ready() -> void:
	reset_alert.visible = false

func _on_reset_save_pressed() -> void:
	reset_alert.visible = true

func _on_agree_pressed() -> void:
	Global.reset_json_file()
	reset_alert.visible = false
	hub.enabled = true
	option.enabled = false

func _on_cancel_pressed() -> void:
	reset_alert.visible = false
	hub.enabled = true
	option.enabled = false
	
