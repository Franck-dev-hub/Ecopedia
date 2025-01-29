extends Node

# Chaque fichier de sauvegarde a ses propres données
var save_data: Dictionary = {}
var cache: Dictionary = {}
const save_paths: Dictionary = {
	"creature": "user://savegame_1.save",
	"money": "user://savegame_2.save"
}

func _ready():
	# Charger les données de chaque fichier au démarrage
	for key in save_paths.keys():
		var path = save_paths[key]
		load_save(path)

func save(save_path):
	if not cache.has(save_path):
		print("Erreur : Aucun cache pour ce fichier: ", save_path)
		return
	
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file:
		save_file.store_var(cache[save_path])  # Sauvegarde uniquement les données pour ce fichier
		save_file.close()
		#print("Sauvegarde réussie pour: ", save_path)
		#print("Données: ", cache[save_path])
	else:
		print("Erreur lors de la sauvegarde.")

func load_save(save_path):
	if not cache.has(save_path):
		cache[save_path] = {}

	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		if save_file:
			cache[save_path] = save_file.get_var()
			save_file.close()
			print("Données chargées depuis ", save_path, " : ", cache[save_path])
		else:
			print("Erreur lors de l'ouverture du fichier: ", save_path)
	else:
		print("Aucune sauvegarde trouvée pour: ", save_path, " Initialisation des données.")
		save(save_path)

func reset_save():
	for path in save_paths.values():
		if FileAccess.file_exists(path):
			var save_file = FileAccess.open(path, FileAccess.WRITE)
			if save_file:
				save_file.store_var({})
				save_file.close()
				cache[path] = {}
				print("Sauvegarde réinitialisée pour: ", path)
		load_save(path)

func get_value(path: String, key: Variant = null, default_value: Variant = null) -> Variant:
	# Si les données pour ce chemin ne sont pas dans le cache, on les charge
	if not cache.has(path):
		load_save(path)
	
	# Si une clé est spécifiée, on retourne la valeur associée à cette clé
	if key != null:
		return cache[path].get(key, default_value)
	# Si aucune clé n'est spécifiée, on retourne toutes les données pour ce chemin
	else:
		return cache[path]

func set_value(path: String, key: String, value: Variant) -> void:
	if not cache.has(path):
		load_save(path)
	cache[path][key] = value
	save(path)
