extends Node2D

@onready var item_list: ItemList = $ItemList

#region Menu
#func _on_entrance_pressed() -> void:
	#get_tree().change_scene_to_file("res://scene/menu/entrance.tscn")
#
#func _on_option_pressed() -> void:
	#get_tree().change_scene_to_file("res://scene/menu/option.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
#endregion

#region Common
func _on_farm_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/1 common/farm.tscn")
	#
#func _on_outback_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_savanna_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_northern_forest_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_city_garden_pressed() -> void:
	#get_tree().change_scene_to_file()
#
##endregion
#
##region Uncommon
#func _on_jungle_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_mountain_meadow_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_swamp_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_desert_oasis_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_woodland_glade_pressed() -> void:
	#get_tree().change_scene_to_file()
##endregion
#
##region Rare
#func _on_jurassic_jungle_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_volcanic_zone_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_ice_age_tundra_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_deep_jungle_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_cave_system_pressed() -> void:
	#get_tree().change_scene_to_file()
##endregion
#
##region Epic
#func _on_savannah_highlands_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_antarctic_peninsula_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_polar_desert_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_floating_islands_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_mystic_swamps_pressed() -> void:
	#get_tree().change_scene_to_file()
##endregion
#
##region Legendary
#func _on_ancient_forest_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_volcanic_wasteland_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_celestial_meadows_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_floating_archipelago_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_eternal_winter_pressed() -> void:
	#get_tree().change_scene_to_file()
##endregion
#
##region Abyss
#func _on_mariana_trench_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_abyssal_plain_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_mid_ocean_ridge_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_deep_sea_hydrothermal_vents_pressed() -> void:
	#get_tree().change_scene_to_file()
#
#func _on_bermuda_triangle_pressed() -> void:
	#get_tree().change_scene_to_file()
##endregion
