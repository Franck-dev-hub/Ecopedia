extends TileMapLayer

@onready var panel: TextureRect = $".."
@onready var tile_map: TileMap = $"../../../../TileMap"
@onready var tile_map_layer: TileMapLayer = $"../../PanelContainer/TileMapLayer"

var get_atlas_coords: Vector2i

func _ready() -> void:
	panel.visible = false
	tile_map_layer.set_cell(Vector2i(0, 0), 1, get_atlas_coords)

func hint(pattern: Array, creature_name: String, atlas_coords: Vector2i):
	get_atlas_coords = atlas_coords
	for y in range(pattern.size()):
		for x in range(pattern[y].size()):
			if pattern[y][x] != 0:  # Tile not empty
				set_cell(Vector2i(x, y), 0, atlas_coords)

func _on_button_pressed() -> void:
	if panel.visible:
		panel.visible = false
	else:
		panel.visible = true
