extends TileMap

@onready var creature_patterns: Dictionary = $Creatures.patterns
@onready var farm: Node2D = $".."
@onready var timer: Timer = $Label/Timer

# Map creature names to sprite coordinates in the atlas
var tiles_id: Dictionary = {
	# Common Insects
	"ant": Vector2i(0, 3),
	"ladybug": Vector2i(1, 3),
	"gnat": Vector2i(2, 3),
	"moth": Vector2i(3, 3),
	"grasshopper": Vector2i(4, 3),
	"praying_mantis": Vector2i(5, 3),
	
	# Common Plants
	"dandelion": Vector2i(0, 4),
	"clover": Vector2i(1, 4),
	"daisy": Vector2i(2, 4),
	"wild_grass": Vector2i(3, 4),
	"poppy": Vector2i(4, 4),
	"calendula": Vector2i(5, 4),
	
	# Uncommon Insects
	"dragonfly": Vector2i(0, 5),
	"wild_bee": Vector2i(1, 5),
	"caterpillar": Vector2i(2, 5),
	"cricket": Vector2i(3, 5),
	"garden_gnat": Vector2i(4, 5),
	
	# Uncommon Plants
	"chamomile": Vector2i(0, 6),
	"lavender": Vector2i(1, 6),
	"mint": Vector2i(2, 6),
	"fern": Vector2i(3, 6),
	"geranium": Vector2i(4, 6),
	
	# Rare Insects
	"monarch_butterfly": Vector2i(0, 7),
	"rhinoceros_beetle": Vector2i(1, 7),
	"blowfly": Vector2i(2, 7),
	"jumping_spider": Vector2i(3, 7),
	
	# Rare Plants
	"giant_sunflower": Vector2i(0, 8),
	"garden_cactus": Vector2i(1, 8),
	"old_roses": Vector2i(2, 8),
	"wild_orchid": Vector2i(3, 8),
	
	# Epic Insects
	"atlas_moth": Vector2i(0, 9),
	"imperial_dragonfly": Vector2i(1, 9),
	"bengal_beetle": Vector2i(2, 9),
	
	# Epic Plants
	"carnivorous_plant": Vector2i(0, 10),
	"giant_cactus": Vector2i(1, 10),
	"water_lotus": Vector2i(2, 10),
	
	# Legendary Insects
	"titanus_giganteus": Vector2i(0, 11),
	"blue_morpho_butterfly": Vector2i(1, 11),
	
	# Legendary Plants
	"baobab": Vector2i(0, 12),
	"madagascar_baobab": Vector2i(1, 12),
	
	# Mythic Insect
	"titan_beetle": Vector2i(0, 13),
	
	# Mythic Plant
	"ghost_orchid": Vector2i(0, 14),
}

var max_x = 10
var max_y = 10
var total_tiles: int = 0
var creature: String = ""

func _ready():
	randomize()
	spawn_random_creature()

func spawn_random_creature():
	var creatures = creature_patterns.keys()
	var random_creature = creatures[randi_range(0, creatures.size() - 1)]
	var creature_data = creature_patterns[random_creature]

	var pattern = creature_data
	var pattern_height = pattern.size()
	
	# Calculate pattern width (maximum width of any row)
	var pattern_width = 0
	for row in pattern:
		pattern_width = max(pattern_width, row.size())

	# Ensure pattern fits within map limits
	var x = randi_range(1, max_x - pattern_width)
	var y = randi_range(1, max_y - pattern_height)

	# Set start position
	var start_pos = Vector2i(x, y)
	creature = random_creature
	print(creature)
	
	show_pattern_at_position(pattern, start_pos, random_creature)

func show_pattern_at_position(pattern, start_pos: Vector2i, random_creature):
	# Get sprite coordinates from atlas based on creature name
	var atlas_coords = tiles_id[random_creature]

	# Place pattern on TileMap
	for y in range(pattern.size()):
		for x in range(pattern[y].size()):
			if pattern[y][x] != 0:  # Check for non-empty tile
				set_cell(1, Vector2(start_pos.x + x, start_pos.y + y), 1, atlas_coords)
				total_tiles += 1

func discovered(count):
	if count == total_tiles:
		timer.start()
		print(creature, " discovered")
		for i in range(max_x + 1):
			for j in range(max_y + 1):
				erase_cell(2, Vector2(i, j))

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
