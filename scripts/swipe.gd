extends Node2D

@export var camera_paths: Array[NodePath]
var cameras: Array[Camera2D] = []

var current_camera_index: int = 0
var start_position: Vector2
var current_position: Vector2
var swiping: bool = false

var length: float = 50
var threshold = 10

func _ready():
	for path in camera_paths:
		var camera = get_node_or_null(path) as Camera2D
		if camera:
			cameras.append(camera)
	
	# Enable first camera only
	for i in range(cameras.size()):
		cameras[i].enabled = (i == current_camera_index)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		if not swiping:
			swiping = true
			start_position = get_global_mouse_position()
			
	if Input.is_action_pressed("left_click"):
		if swiping:
			current_position = get_global_mouse_position()
			if start_position.distance_to(current_position) >= length:
				if abs(start_position.y - current_position.y) <= threshold:
					if current_position.x > start_position.x:
						print("Swipe vers la gauche")
						switch_camera(-1)  # Next camera
						swiping = false
					elif current_position.x < start_position.x:
						print("Swipe vers la droite")
						switch_camera(1)  # Past camera
						swiping = false

				if abs(start_position.x - current_position.x) <= threshold:
					if current_position.y > start_position.y:
						print("Swipe vers le bas")
					else:
						print("Swipe vers le haut")
					swiping = false
	else:
		swiping = false

func switch_camera(direction: int):
	# Disable curent camera
	cameras[current_camera_index].enabled = false
	
	current_camera_index = (current_camera_index + direction) % cameras.size()
	if current_camera_index < 0:
		current_camera_index = cameras.size() - 1
	
	# Enable new camera
	cameras[current_camera_index].enabled = true
