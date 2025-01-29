extends Control

#region Variables
# Pages
@onready var main_page: Control = $"."
@onready var option_page: Control = $"../Option page"
@onready var reset_page: Control = $"../Reset page"
@onready var places: VBoxContainer = $Places
@onready var reset_done_page: Control = $"../Reset done page"

# Cameras
@onready var camera_main_page: Camera2D = $"../.."
@onready var camera_capture: Camera2D = $"../../../../Capture"

#endregion

#region Game
func _ready() -> void:
	initialise()

func _process(_delta: float) -> void:
	pass

func initialise():
	main_page.visible = true
	option_page.visible = false
	reset_page.visible = false
	places.visible = false
	reset_done_page.visible = false

func switch_to_camera(camera: Camera2D):
	# Disabled all cameras
	for cam in get_tree().get_nodes_in_group("Cameras"):
		cam.enabled = false
	
	# Enabled wanted camera
	camera.enabled = true

#endregion

#region Menu
func _on_capture_pressed():
	if places.visible:
		places.visible = false
	elif not places.visible:
		places.visible = true
	else:
		return "Capture button error"

func _on_right_pressed():
	pass # Replace with function body.
	
func _on_options_pressed():
	main_page.visible = false
	option_page.visible = true

func _on_quitter_pressed() -> void:
	get_tree().quit()

#endregion

#region creatures
func _on_cloportes_pressed() -> void:
	switch_to_camera(camera_capture)
	
#endregion
