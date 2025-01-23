class_name Creature extends Node2D

@export var sprite_position: Vector2i = Vector2i(0, 0)
@export var pattern: Array = [
		[0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0]
	]
@export_enum("Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic")
var rarity: String = "Common"

var creature_name: String

func _ready():
	creature_name = name
