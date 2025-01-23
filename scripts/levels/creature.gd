extends Camera2D

@onready var label: Label = $HBoxContainer/Label

var current_creature: String
var current_value

func _ready() -> void:
	# Get current creature name
	for i in Global.farm_creature_count.keys():
		if i == name:
			current_creature = i
	
	# Get current stat about the creature
	current_value = Global.farm_creature_count.get(current_creature)
	
	# Display creature name + value
	label.text = current_creature + ": " + str(current_value)
