extends Node

# Init save file + datas
var save_data: Dictionary = {}
var cache: Dictionary = {}
@export var save_paths: Dictionary = {
	"creature": "user://savegame_1.save",
	"money": "user://savegame_2.save",
	"capture_cost": "user://savegame_3.save",
}

func _ready():
	# Load save file + datas
	for key in save_paths.keys():
		var path = save_paths[key]
		load_save(path)

func save(save_path):
	if not cache.has(save_path):
		print("Error: No cache for this file: ", save_path)
		return
	
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file:
		save_file.store_var(cache[save_path])
		save_file.close()
		#print("Backup achieved for: ", save_path)
		#print("Datas: ", cache[save_path])
	else:
		print("Backup error")

func load_save(save_path):
	if not cache.has(save_path):
		cache[save_path] = {}

	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		if save_file:
			cache[save_path] = save_file.get_var()
			save_file.close()
			print("Load datas from ", save_path, " : ", cache[save_path])
		else:
			print("Error opening file: ", save_path)
	else:
		print("No backup found for: ", save_path, "Data initialization.")
		save(save_path)

func reset_save():
	for path in save_paths.values():
		if FileAccess.file_exists(path):
			var save_file = FileAccess.open(path, FileAccess.WRITE)
			if save_file:
				save_file.store_var({})
				save_file.close()
				cache[path] = {}
				print("Reset backup for: ", path)
		load_save(path)

func get_value(save_path: String, key: Variant = null, default_value: Variant = null) -> Variant:
	# If the data for this path is not in the cache, we load it.
	if not cache.has(save_path):
		load_save(save_path)
	
	# If a key is specified, we return the value associated with this key
	if key != null:
		return cache[save_path].get(key, default_value)
	# If no key is specified, all the data for this path is returned
	else:
		return cache[save_path]

func set_value(save_path: String, key: String, value: Variant) -> void:
	if not cache.has(save_path):
		load_save(save_path)
	cache[save_path][key] = value
	save(save_path)
