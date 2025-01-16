extends Node2D

@onready var stamina_label: Label = $TileMap/GUI/Stamina
@onready var tile_map: TileMap = $TileMap
@onready var h_box_container: HBoxContainer = $TileMap/GUI/HBoxContainer

@export var stamina: int = 100

var tile_count: int = 0
var clicked_cells: Array = []

func _ready() -> void:
	h_box_container.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		# Conversion de la position de la souris en coordonnées de tuiles
		var tile_pos: Vector2i = tile_map.local_to_map(to_local(get_global_mouse_position()))
		var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position())

		if clicked_cell:
			# Manage tile already clicked
			if clicked_cells.has(clicked_cell):
				return
			clicked_cells.append(clicked_cell)
			
			# Load tilemap custom datas
			var tile_creature = tile_map.get_cell_tile_data(1, clicked_cell)

			if tile_map.get_cell_tile_data(2, clicked_cell):
				stamina -= 1
				update_stamina()

			# Debug
			if tile_creature:
				tile_count += 1
				if tile_count == tile_map.total_tiles:
					tile_map.discovered()

			# Efface la cellule
			tile_map.erase_cell(2, tile_pos)
			
	if stamina == 0:
		game_end()

func update_stamina() -> void:
	stamina_label.text = "Stamina: " + str(stamina)

func game_end():
	if h_box_container != null:
		h_box_container.visible = true
	else:
		get_tree().quit()


func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main.tscn")
