extends Camera2D

@onready var creature_count: Label = $"Control/Main page/Creature count"
@onready var terrarium_layer: TileMapLayer = $"Terrarium layer"
@onready var creatures: Node2D = $"../../../Global/Creatures"

func _ready():
	creature_count.text = name + ": " + str(GlobalSave.get_value(GlobalSave.save_paths["creature"], name))

	if get_tree().get_nodes_in_group("Creatures"):
		for creature in get_tree().get_nodes_in_group("Creatures"):
			if creature.name == name:
				if creature.sprite_position:
					print(name)
					terrarium_layer.set_cell(Vector2i(3, 10), 0, creature.sprite_position)
				else:
					print("Sprite position not found")
	else:
		print("Node not find")

#region On button pressed

func _on_terrarium_left_pressed() -> void:
	GlobalTerrarium.switch_terrarium(-1)

func _on_terrarium_right_pressed() -> void:
	GlobalTerrarium.switch_terrarium(1)

func _on_home_pressed() -> void:
	if GlobalTerrarium.main_camera:
		GlobalTerrarium.main_camera.make_current()
	else:
		print("Erreur : main_camera a été supprimée ou est invalide")

func _on_start_pressed() -> void:
	GlobalTerrarium.switch_terrarium(0, 0)

func _on_end_pressed() -> void:
	GlobalTerrarium.switch_terrarium(0, 999999)
	
#endregion
