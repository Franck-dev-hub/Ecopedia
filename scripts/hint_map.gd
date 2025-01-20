extends TileMapLayer

@onready var panel: Panel = $".."
@onready var button: Button = $TileMap/GUI/HintPanel/Button

func _ready() -> void:
	panel.visible = false

func hint(pattern: Array, creature_name: String, atlas_coords: Vector2i):
	for y in range(pattern.size()):
		for x in range(pattern[y].size()):
			if pattern[y][x] != 0:  # Tile not empty
				set_cell(Vector2i(x, y), 0, atlas_coords)

func _on_button_pressed() -> void:
	if panel.visible:
		panel.visible = false
	else:
		panel.visible = true
