extends Node2D

func _ready() -> void:
	if not GlobalSave.get_value(GlobalSave.save_paths["capture_cost"]):
		GlobalSave.set_value(GlobalSave.save_paths["capture_cost"], "Cloportes", 100)
		GlobalSave.set_value(GlobalSave.save_paths["capture_cost"], "Fourmis", 500)
		GlobalSave.set_value(GlobalSave.save_paths["capture_cost"], "Iules", 1000)
		GlobalSave.set_value(GlobalSave.save_paths["capture_cost"], "Araignees", 5000)
