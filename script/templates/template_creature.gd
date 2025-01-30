extends Node2D

@export var sprite_position: Vector2i = Vector2i(0, 0)
@export var pattern: Array = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
@export var coin_value: int = 1
@export var color: String

@export_enum ("Cloporte")
var family: String = "Cloporte"

@export_enum ("Commun", "Peu_commun", "Rare", "Epic", "Légendaire", "Mythique")
var rarity: String = "Commun"

func _ready():
	var _creature_name: String = name
