extends Node2D

@onready var label: Label = $TileMap/Label
@onready var tile_map: TileMap = $TileMap

@export var stamina: int = 100

var tile_count: int = 0

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		# Conversion de la position de la souris en coordonnées de tuiles
		var tile_pos: Vector2i = tile_map.local_to_map(to_local(get_global_mouse_position()))
		var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position())

		if clicked_cell:
			var tile_creature = tile_map.get_cell_tile_data(1, clicked_cell)
			var tile_rarity = tile_map.get_cell_tile_data(1, clicked_cell)
			var tile_is_insect = tile_map.get_cell_tile_data(1, clicked_cell)
			
			if tile_map.get_cell_tile_data(2, clicked_cell):
				stamina -= 1
				update_stamina()

			# Debug
			if tile_creature:
				tile_count += 1
				tile_map.discovered(tile_count)

			# Efface la cellule
			tile_map.erase_cell(2, tile_pos)
			
	if stamina == 0:
		get_tree().quit()

func update_stamina() -> void:
	label.text = "Stamina: " + str(stamina)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main.tscn")
