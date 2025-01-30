extends Node2D

@onready var main_camera: Camera2D = get_tree().root.get_node("Main/Général/Main page/Main")
@onready var main_page: Control = get_tree().root.get_node("Main/Général/Main page/Main/Control/Main page")

var cameras: Array = []
var current_camera: int = 0
var number_of_cameras: int

func _ready() -> void:
	get_cameras()

func get_cameras():
	# Get all creature cameras
	for camera in get_tree().get_nodes_in_group("Terrarium_camera"):
		if not cameras.has(camera):
			if GlobalSave.get_value(GlobalSave.save_paths["creature"], camera.name):
				cameras.append(camera)

	number_of_cameras = cameras.size()
	if main_camera:
		print(main_camera)
		switch_to_camera(main_camera)
	else:
		print("Erreur : main_camera a été supprimée ou est invalide")


func switch_to_camera(camera_node: Camera2D):
	# Disabled all cameras
	for cam in get_tree().get_nodes_in_group("Cameras"):
		cam.enabled = false
		
	for cam in get_tree().get_nodes_in_group("Terrarium_camera"):
		cam.enabled = false
		
	# Enabled wanted camera
	camera_node.enabled = true

func switch_terrarium(direction: int, camera_index = null):
	if cameras.is_empty():
		print("No cameras found")
		return

	cameras[current_camera].enabled = false

	if camera_index != null:
		current_camera = clamp(camera_index, 0, number_of_cameras - 1)
	elif current_camera == 0 and direction == -1:
		switch_to_camera(main_camera)
	else:
		current_camera = clamp(current_camera + direction, 0, number_of_cameras - 1)
	cameras[current_camera].enabled = true

func _on_right_pressed() -> void:
	if cameras.size() != 0:
		cameras[current_camera].enabled = true
		
		# Disable other cameras
		for camera in get_tree().get_nodes_in_group("Cameras"):
			camera.enabled = false
