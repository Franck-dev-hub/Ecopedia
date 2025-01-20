extends TileMap

@onready var score_label: Label = $GUI/Score
@onready var farm: Node2D = $".."
@onready var timer: Timer = $GUI/Stamina/Timer
@onready var creatures: Node2D = $Creatures
@onready var hint_map: TileMapLayer = $GUI/HintPanel/Panel/HintMap

var tiles_id_script
var tiles_id

# Map coordinates
var start_x: int = 1
var start_y: int = 3
var max_x: int = 7
var max_y: int = 9

var total_tiles: int = 0

# Rarity probability
@export var rarity_weight = {
	"Common": 59.5, # Pattern 6
	"Uncommon": 25, # Pattern 5
	"Rare": 10, # Pattern 4
	"Epic": 4, # Pattern 3
	"Legendary": 1, # Pattern 2
	"Mythic": 0.5 # Pattern 1
}

# Dictionary to load creature for rarity
var creature_by_rarity: Dictionary = {}

func _ready():
	#set_cell(2, Vector2i(6, 7), 1, Vector2i(0, 14)) # Debug / test
	tiles_id = {}
	creature_by_rarity = {
		"Common": [],
		"Uncommon": [],
		"Rare": [],
		"Epic": [],
		"Legendary": [],
		"Mythic": []
	}

	# Check rarity categories
	for rarity_node in creatures.get_children():
		# Check if rarity is ok
		if rarity_node.name in creature_by_rarity:
			# Check all creatures in categories
			for creature_node in rarity_node.get_children():
				if creature_node is Creature:
					# Add creature by his rarity
					creature_by_rarity[rarity_node.name].append(creature_node)
					
					# Append creature and sprite
					tiles_id[creature_node.creature_name.to_lower()] = creature_node.sprite_position
		else:
			print("Rarity unknown :", rarity_node.name)

	randomize()
	spawn_tilset()
	spawn_random_creature()
	score_label.text = "Score: " + str(Global.score)

func spawn_tilset():
	# Background
	for x in range(start_x, max_x):
		for y in range(start_y, max_y):
			var bg_x_tile = randi_range(3, 5)
			var bg_y_tile = randi_range(0, 2)
			set_cell(0, Vector2i(x, y), 1, Vector2i(bg_x_tile, bg_y_tile))
	# Foreground
	for x in range(start_x, max_x):
		for y in range(start_y, max_y):
			var fg_x_tile = randi_range(0, 2)
			var fg_y_tile = randi_range(0, 2)
			set_cell(2, Vector2i(x, y), 1, Vector2i(fg_x_tile, fg_y_tile))

# Load all creatures
func load_all_creatures():
	var creature_folders = creatures.get_children()

	for rarity_folder in creature_folders:
		var rarity = rarity_folder.name
		if !creature_by_rarity.has(rarity):
			creature_by_rarity[rarity] = []

		for creature_scene in rarity_folder.get_children():
			var creature_instance = creature_scene.duplicate()
			creature_by_rarity[rarity].append(creature_instance)

# Load a creature
func spawn_random_creature():
	# Select a rarity
	var selected_rarity = choose_rarity()
	
	# Get creature list
	var creatures_list = creature_by_rarity[selected_rarity]

	# Get random creature by his rarity
	var random_creature = creatures_list[randi_range(0, creatures_list.size() - 1)]
	var pattern = random_creature.pattern

	# Calculate size of pattern
	var pattern_height = pattern.size()
	var pattern_width = 0
	for row in pattern:
		pattern_width = max(pattern_width, row.size())

	# Random positionement for pattern
	var x = randi_range(start_x, max_x - pattern_width)
	var y = randi_range(start_y, max_y - pattern_height)
	var start_pos = Vector2i(x, y)

	print("Name : ", random_creature.creature_name)
	print("Rarity :", selected_rarity)

	# Display pattern
	show_pattern_at_position(pattern, start_pos, random_creature.creature_name)

# Place pattern on tilemap
func show_pattern_at_position(pattern, start_pos: Vector2i, creature_name: String):
	var lower_creature_name = creature_name.to_lower()

	# Check if key is in dictionnary
	if tiles_id.has(lower_creature_name):
		var atlas_coords = tiles_id[lower_creature_name]

		# Display hint
		hint_map.hint(pattern, creature_name, atlas_coords)

		# Place pattern
		for y in range(pattern.size()):
			for x in range(pattern[y].size()):
				if pattern[y][x] != 0:  # Tile not empty
					set_cell(1, Vector2i(start_pos.x + x, start_pos.y + y), 1, atlas_coords)
					total_tiles += 1

# Random rarity selection
func choose_rarity() -> String:
	var total_weight = 0
	for weight in rarity_weight.values():
		total_weight += weight
	
	var random_value = randf_range(0, total_weight)
	var cumulative_weight = 0.0
	print("Probability: ", int(random_value))

	for rarity in rarity_weight.keys():
		cumulative_weight += rarity_weight[rarity]
		if random_value <= cumulative_weight:
			return rarity

	return "Common"

# If creature found
func discovered():
	timer.start()
	Global.score += 1
	score_label.text = "Score: " + str(Global.score)
	for i in range(max_x + 1):
		for j in range(max_y + 1):
			erase_cell(2, Vector2i(i, j))

func _on_timer_timeout() -> void:
	print("end")
	farm.game_end()
