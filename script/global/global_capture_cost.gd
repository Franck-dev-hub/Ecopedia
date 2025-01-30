extends Node2D

func _ready() -> void:
	if not global_save.get_value(global_save.save_paths["capture_cost"]):
		global_save.set_value(global_save.save_paths["capture_cost"], "Cloportes", 100)
		global_save.set_value(global_save.save_paths["capture_cost"], "Fourmis", 500)
		global_save.set_value(global_save.save_paths["capture_cost"], "Iules", 1000)
		global_save.set_value(global_save.save_paths["capture_cost"], "Araignees", 5000)
