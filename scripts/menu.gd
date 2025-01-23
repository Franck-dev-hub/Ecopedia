extends Button

@export var button = Node
@export var button_ext_1 = Node
@export var button_ext_2 = Node
@export var button_ext_3 = Node
@export var button_ext_4 = Node
@export var button_ext_5 = Node

func _ready():
	button.visible = false

func _on_pressed() -> void:
	if not button.visible:
		button.visible = true
		button_ext_1.visible = false
		#button_ext_2.visible = false
		#button_ext_3.visible = false
		#button_ext_4.visible = false
		#button_ext_5.visible = false
	elif button.visible:
		button.visible = false
		button_ext_1.visible = true
		#button_ext_2.visible = true
		#button_ext_3.visible = true
		#button_ext_4.visible = true
		#button_ext_5.visible = true
