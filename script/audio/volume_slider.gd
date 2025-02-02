extends HSlider

@export var bus_name: String

var bus_index: int

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	
	if bus_index == -1:
		print("Erreur : Bus audio introuvable -", bus_name)
		return

	var saved_volume = GlobalSave.get_value(GlobalSave.save_paths["options"], str(bus_index), 1.0)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(saved_volume))
	value = saved_volume

func _on_value_changed(value: float) -> void:
	if bus_index == -1:
		print("Erreur : Bus audio introuvable")
		return

	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	GlobalSave.set_value(GlobalSave.save_paths["options"], str(bus_index), value)
