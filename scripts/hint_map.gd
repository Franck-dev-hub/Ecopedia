extends TileMapLayer

@onready var panel: TextureRect = $".."
@onready var tile_map: TileMap = $"../../../../TileMap"
@onready var tile_map_layer: TileMapLayer = $"../../PanelContainer/TileMapLayer"
@onready var hint_bg: TileMapLayer = $"../Hint_bg"

var get_atlas_coords: Vector2i
var get_panel: TextureRect

var pattern_rows = 0
var pattern_cols = 0

func _ready() -> void:
	# Hint button
	panel.visible = false
	tile_map_layer.set_cell(Vector2i(0, 0), 1, get_atlas_coords)

func hint(pattern: Array, _creature_name: String, atlas_coords: Vector2i):
	_ready()
	get_atlas_coords = atlas_coords
	get_panel = panel

	# Random tiles for background
	var background_x = randi_range(0, 2)
	var background_y = randi_range(0, 2)
	var background_atlas_coords = Vector2i(background_x, background_y)
	
	# Display pattern + background
	for y in range(pattern.size()): # Rows
		pattern_rows += 1
		for x in range(pattern[y].size()): # Cols
			if pattern_rows == 1:
				pattern_cols += 1
			hint_bg.set_cell(Vector2i(x, y), 0, background_atlas_coords)
			if pattern[y][x] != 0:  # Tile not empty
				set_cell(Vector2i(x, y), 0, atlas_coords)
	
	var panel_width = (pattern_cols + 2) * 32
	var panel_height = (pattern_rows + 2) * 32
	#get_panel.rect_size = Vector2(panel_width, panel_height)
	
	print("row: ", pattern_rows)
	print("col: ", pattern_cols)

func _on_button_pressed() -> void:
	if panel.visible:
		tile_map.visible = true
		tile_map_layer.visible = true
		panel.visible = false
	else:
		tile_map.visible = false
		tile_map_layer.visible = false
		panel.visible = true
