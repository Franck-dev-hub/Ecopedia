extends Camera2D

@onready var creature_count: Label = $"Control/Main page/Creature count"

func _ready():
	creature_count.text = name + ": " + str(GlobalSave.get_value(GlobalSave.save_paths["creature"], name))

#region On button pressed

func _on_terrarium_left_pressed() -> void:
	GlobalTerrarium.switch_terrarium(-1)

func _on_terrarium_right_pressed() -> void:
	GlobalTerrarium.switch_terrarium(1)

func _on_home_pressed() -> void:
	GlobalTerrarium.switch_to_camera(GlobalTerrarium.main_camera)

func _on_start_pressed() -> void:
	GlobalTerrarium.switch_terrarium(0, 0)

func _on_end_pressed() -> void:
	GlobalTerrarium.switch_terrarium(0, 999999)
	
#endregion
