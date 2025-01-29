extends Control

#region Variables

# Pages
@onready var main_page: Control = $"."
@onready var game_end_page: Control = $"../Game end page"

# Labels
@onready var stamina_label: Label = $Stamina

# Buttons
@onready var quit_button: Button = $HBoxContainer/Quit

# Timers
@onready var stamina_timer: Timer = $Stamina/Timer

# Tilemaps
@onready var tilemaps: Node2D = $"../../Tilemaps"
@onready var background_layer: TileMapLayer = $"../../Tilemaps/Background layer"
@onready var creature_layer: TileMapLayer = $"../../Tilemaps/Creature layer"
@onready var foreground_layer: TileMapLayer = $"../../Tilemaps/Foreground layer"
@onready var hint_button_layer: TileMapLayer = $"../../Tilemaps/Hint button layer"
@onready var hint_background_layer: TileMapLayer = $"../../Tilemaps/Hint background layer"
@onready var hint_creature_layer: TileMapLayer = $"../../Tilemaps/Hint creature layer"

# Game state variables
var tile_count: int = 0
var clicked_cells: Array = []

# Save data
var save_dict: Dictionary

# Stamina
var stamina: int = 10

# Hint system
@onready var creature_label: Label = $"Hint button/Creature"
var hint_button_pressed: bool = false
var pattern_rows: int = 0
var pattern_cols: int = 0
var get_atlas_coords: Vector2i
var hint_open: bool = false

# Creatures management
@onready var creatures: Node2D = $"../../../Global/Creatures"
@onready var hint_button: TextureButton = $"Hint button"
var current_creature: String = ""
var tiles_id: Dictionary = {}
var total_tiles: int = 0

# Map tiles coordinates
var start_map_x: int = 1
var end_map_x: int = 6
var start_map_y: int = 5
var end_map_y: int = 10
var tile_size: int = 64

# Background tiles coordinates
var start_background_x_tile: int = 3
var end_background_x_tile: int = 5
var start_background_y_tile: int = 0
var end_background_y_tile: int = 2

# Foreground tiles coordinates
var start_foreground_x_tile: int = 0
var end_foreground_x_tile: int = 2
var start_foreground_y_tile: int = 0
var end_foreground_y_tile: int = 2

# Rarity probability mapping
var rarity_weight: Dictionary = {
	"Commun": 59.5,
	"Peu_commun": 25,
	"Rare": 10,
	"Epic": 4,
	"Légendaire": 1,
	"Mythique": 0.5
}

# Dictionary to load creatures by rarity
var creature_by_rarity: Dictionary = {
		"Commun": [],
		"Peu_commun": [],
		"Rare": [],
		"Epic": [],
		"Légendaire": [],
		"Mythique": []
	}

#endregion

#region Game Lifecycle
func _ready() -> void:
	print("Display size in px: ", DisplayServer.screen_get_size())
	game_end_page.visible = false
	pre_load_rarity()
	randomize()
	spawn_tileset()
	spawn_random_creature()

func _process(_delta: float) -> void:
	handle_left_click()

#endregion

#region Game Interaction
func handle_left_click():
	if Input.is_action_just_pressed("left_click") and not hint_button_pressed:
		# Get mouse position as tile coordinates
		var cell = foreground_layer.local_to_map(foreground_layer.get_local_mouse_position())

		# Process click on tile
		if cell and not clicked_cells.has(cell):
			clicked_cells.append(cell)

			# Handle tile actions
			var tile_creature = creature_layer.get_cell_tile_data(cell)
			if foreground_layer.get_cell_tile_data(cell):
				stamina -= 1
				print(stamina)
				update_stamina()

			if tile_creature:
				tile_count += 1
				if tile_count == total_tiles:
					discover(true)

			# Erase the clicked tile
			print("Erasing tile at position: ", cell)
			foreground_layer.erase_cell(cell)

		# End game if stamina is 0
		if stamina == 0:
			discover(false)

#endregion

#region UI Management

func update_stamina() -> void:
	stamina_label.text = "Stamina: " + str(stamina)

func reveal_after_play_again():
	hint_button.visible = true
	quit_button.visible = true
	creature_label.visible = true
	tilemaps.visible = true
	game_end_page.visible = false

#endregion

#region Game Flow
func game_end():
	if game_end_page != null:
		game_end_page.visible = true
	else:
		get_tree().quit()

func discover(win: bool):
	# Hide elements before ending the game
	hint_button.visible = false
	quit_button.visible = false
	creature_label.visible = false
	
	# Hide layers
	foreground_layer.visible = false
	
	save(win)
	erase_layer(foreground_layer, true)

func save(win: bool):
	if win:
		if Global_save.get_value(Global_save.save_paths["creature"], current_creature):
			var current_value = Global_save.get_value(Global_save.save_paths["creature"], current_creature)
			current_value += 1
			Global_save.set_value(Global_save.save_paths["creature"], current_creature, current_value)
			print(current_creature, ": ", current_value)
		else:
			var current_value = 1
			Global_save.set_value(Global_save.save_paths["creature"], current_creature, current_value)
			print(current_creature, ": ", current_value)

#endregion

#region Button Handlers
func _on_rejouer_pressed() -> void:
	print("Play again")

	reset_game_state()

	# Update UI
	update_stamina()
	reveal_after_play_again()
	reset_map()

func _on_fin_pressed() -> void:
	print("return")
	get_tree().change_scene_to_file("res://scene/main.tscn")

func _on_quit_pressed() -> void:
	print("quit")
	get_tree().change_scene_to_file("res://scene/main.tscn")

func _on_timer_timeout() -> void:
	print("Timer end")
	foreground_layer.visible = true
	tilemaps.visible = false
	game_end() 

func _on_hint_button_pressed() -> void:
	if not hint_open:
		hint_open = true
		# Display hint
		creature_label.visible = true
		hint_background_layer.visible = true
		hint_creature_layer.visible = true
		
		# Hide  main infos
		background_layer.visible = false
		creature_layer.visible = false
		foreground_layer.visible = false

	else:
		hint_open = false
		# Display main infos
		background_layer.visible = true
		creature_layer.visible = true
		foreground_layer.visible = true
		
		# Hide hint
		creature_label.visible = false
		hint_background_layer.visible = false
		hint_creature_layer.visible = false

#endregion

#region Map & Creature Setup
func pre_load_rarity():
	# Load creatures into the dictionary
	if get_tree().get_nodes_in_group("Creatures"):
		for creature in get_tree().get_nodes_in_group("Creatures"):
			if creature.rarity and creature.sprite_position:
				var rarity = creature.rarity
				var sprite_position = creature.sprite_position
				# Add creature to the correct rarity group
				if creature_by_rarity.has(rarity):
					if not creature_by_rarity[rarity].has(creature):
						creature_by_rarity[rarity].append(creature)
						tiles_id[creature.name.to_lower()] = sprite_position
					else:
						print("Creature allready in rarity dict")
				else:
					print("Unknown rarity for creature: ", creature.name, " with rarity: ", rarity)
			else:
				print("Creature: ", creature.name, " is missing 'rarity' or 'sprite_position' metadata.")
	else:
		print("Incorrect group")

func spawn_tileset():
	randomize()
	# Spawn background tiles
	for x in range(start_map_x, end_map_x):
		for y in range(start_map_y, end_map_y):
			var background_x_tile = randi_range(start_background_x_tile, end_background_x_tile)
			var background_y_tile = randi_range(start_background_y_tile, end_background_y_tile)
			background_layer.set_cell(Vector2i(x, y), 0, Vector2i(background_x_tile, background_y_tile))
	# Spawn foreground tiles
	for x in range(start_map_x, end_map_x):
		for y in range(start_map_y, end_map_y):
			var foreground_x_tile = randi_range(start_foreground_x_tile, end_foreground_x_tile)
			var foreground_y_tile = randi_range(start_foreground_y_tile, end_foreground_y_tile)
			foreground_layer.set_cell(Vector2i(x, y), 0, Vector2i(foreground_x_tile, foreground_y_tile))

func reset_map():
	# Reset variables and layers
	reset_game_state()
	spawn_tileset()
	spawn_random_creature()

func reset_game_state():
	tile_count = 0
	total_tiles = 0
	clicked_cells.clear()
	stamina = 10
	update_stamina()

	# Reset tilemap layers
	reset_layers()

func reset_layers():
	erase_layer(background_layer, false)
	erase_layer(creature_layer, false)
	erase_layer(foreground_layer, false)
	erase_layer(hint_button_layer, false)
	erase_layer(hint_background_layer, false)
	erase_layer(hint_creature_layer, false)

func erase_layer(layer, enabled_timer):
	if enabled_timer:
		stamina_timer.start()
	for i in range(end_map_x + 1):
		for j in range(end_map_y + 1):
			layer.erase_cell(Vector2i(i, j))

func spawn_random_creature():
	randomize()
	var selected_rarity = choose_rarity()

	# Ensure creatures for this rarity exist
	if not creature_by_rarity.has(selected_rarity) or creature_by_rarity[selected_rarity].size() == 0:
		print(creature_by_rarity)
		print("No creatures available for rarity:", selected_rarity)
		return

	# Select a random creature from the list
	var creatures_list = creature_by_rarity[selected_rarity]
	var random_creature = creatures_list[randi_range(0, creatures_list.size() - 1)]
	current_creature = random_creature.name
	var pattern

	# Retrieve the creature's pattern
	if random_creature.pattern:
		pattern = random_creature.get("pattern")
	else:
		print("Creature is missing 'pattern' metadata:", random_creature.name)
		return

	# Calculate the pattern dimensions
	var pattern_height = pattern.size()
	var pattern_width = 0
	for row in pattern:
		pattern_width = max(pattern_width, row.size())

	# Generate random position for placing the pattern
	var x = randi_range(start_map_x, end_map_x - pattern_width)
	var y = randi_range(start_map_y, end_map_y - pattern_height)
	var start_pos = Vector2i(x, y)

	# Update UI with the current creature's name
	creature_label.text = current_creature
	print("Name : ", current_creature)
	print("Rarity :", selected_rarity)

	# Place the pattern at the selected position
	show_pattern_at_position(pattern, start_pos, current_creature)
	
func show_pattern_at_position(pattern, start_pos: Vector2i, creature_name: String):
	var lower_creature_name = creature_name.to_lower()

	# Check if the creature's sprite exists in the tiles dictionary
	if tiles_id.has(lower_creature_name):
		var atlas_coords = tiles_id[lower_creature_name]

		# Display the hint for the creature
		hint(pattern, creature_name, atlas_coords)

		# Place the pattern on the tilemap
		for y in range(pattern.size()):
			for x in range(pattern[y].size()):
				if pattern[y][x] != 0:  # If tile is not empty
					creature_layer.set_cell(Vector2i(start_pos.x + x, start_pos.y + y), 0, atlas_coords)
					total_tiles += 1

#endregion

#region Utility Functions
func choose_rarity() -> String:
	var total_weight = 0
	for weight in rarity_weight.values():
		total_weight += weight

	var random_value = randf_range(0, total_weight)
	var cumulative_weight = 0.0
	print("Probability: ", int(random_value))

	# Determine rarity based on weighted probabilities
	for rarity in rarity_weight.keys():
		cumulative_weight += rarity_weight[rarity]
		if random_value <= cumulative_weight:
			return rarity

	return "Commun"

func hint(pattern: Array, _creature_name: String, atlas_coords: Vector2i):
	hint_button_layer.set_cell(Vector2i(3, 3), 0, atlas_coords)
	pattern_rows = 0
	pattern_cols = 0
	get_atlas_coords = atlas_coords
	
	# Random background tiles
	var background_x = randi_range(start_background_x_tile, end_background_x_tile)
	var background_y = randi_range(start_background_y_tile, end_background_y_tile)
	var background_atlas_coords = Vector2i(background_x, background_y)

	# Compute pattern size
	for y in range(pattern.size()):
		pattern_rows += 1
		for x in range(pattern[y].size()):
			if pattern_rows == 1:
				pattern_cols += 1

	# Compute center position
	var viewport_size = get_viewport().size
	var pattern_width = pattern_cols * 64
	var pattern_height = pattern_rows * 64
	var start_offset = Vector2i(
		(viewport_size.x / 2 - pattern_width / 2) / tile_size,
		(viewport_size.y / 2 - pattern_height / 2) / tile_size + 1
	)

	# Display creature + background in the center
	for y in range(pattern_rows):
		for x in range(pattern_cols):
			var tile_pos = Vector2i(x, y) + start_offset
			hint_background_layer.set_cell(tile_pos, 0, background_atlas_coords)
			if pattern[y][x] != 0:
				hint_creature_layer.set_cell(tile_pos, 0, atlas_coords)

#endregion
