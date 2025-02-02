extends Node2D

@onready var main_camera: Camera2D = get_tree().root.get_node("Main/Général/Main page/Main")
@onready var main_page: Control = get_tree().root.get_node("Main/Général/Main page/Main/Control/Main page")

var cameras: Array = []
var current_camera: int = 0
var number_of_cameras: int

func _ready() -> void:
	get_cameras()

func get_cameras():
	main_camera = get_tree().root.get_node("Main/Général/Main page/Main")
	main_page = get_tree().root.get_node("Main/Général/Main page/Main/Control/Main page")
	cameras.clear()
	current_camera = 0

	# Get all creature cameras
	for camera in get_tree().get_nodes_in_group("Terrarium_camera"):
		if not cameras.has(camera) and is_instance_valid(camera):
			if GlobalSave.get_value(GlobalSave.save_paths["creature"], camera.name):
				cameras.append(camera)

	number_of_cameras = cameras.size()
	if main_camera and is_instance_valid(main_camera):
		print(main_camera)
		main_camera.make_current()
	else:
		print("Erreur : main_camera a été supprimée ou est invalide")

func switch_terrarium(direction: int, camera_index = null):
	if cameras.is_empty():
		print("No cameras found")
		return

	if camera_index != null:
		current_camera = clamp(camera_index, 0, number_of_cameras - 1)
		if is_instance_valid(cameras[current_camera]):
			cameras[current_camera].make_current()
		else:
			print("Camera at index ", current_camera, " is freed.")
	elif current_camera == 0 and direction == -1:
		if main_camera and is_instance_valid(main_camera):
			main_camera.make_current()
		else:
			print("Erreur : main_camera a été supprimée ou est invalide")
	else:
		current_camera = clamp(current_camera + direction, 0, number_of_cameras - 1)
		if is_instance_valid(cameras[current_camera]):
			cameras[current_camera].make_current()
		else:
			print("Camera at index ", current_camera, " is freed.")

func _on_right_pressed() -> void:
	if cameras.size() != 0:
		cameras[current_camera].make_current()
