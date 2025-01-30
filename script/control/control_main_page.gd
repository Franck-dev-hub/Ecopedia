extends Control

#region Variables
# Pages
@onready var main_page: Control = $"."
@onready var option_page: Control = $"../Option page"
@onready var reset_page: Control = $"../Reset page"
@onready var places: VBoxContainer = $Places
@onready var reset_done_page: Control = $"../Reset done page"

# Cameras
@onready var camera_main_page: Camera2D = $"../.."
@onready var camera_capture: Camera2D = $"../../../../Capture"

# Labels
@onready var coins_label: Label = $"Money/Coins label"
@onready var cloportes: Button = $Places/Cloportes
@onready var fourmis: Button = $Places/Fourmis
@onready var iules: Button = $Places/Iules
@onready var araignees: Button = $"Places/Araignees"

#endregion

#region Game
func _ready() -> void:
	# Init family cost
	if not global_save.get_value(global_save.save_paths["capture_cost"], "Cloportes"):
		global_capture_cost._ready()
	cloportes.text = "Cloportes\n" + str(global_save.get_value(global_save.save_paths["capture_cost"], "Cloportes")) + " par capture"
	fourmis.text = "Fourmis\n" + str(global_save.get_value(global_save.save_paths["capture_cost"], "Fourmis")) + " par capture"
	iules.text = "Iules\n" + str(global_save.get_value(global_save.save_paths["capture_cost"], "Iules")) + " par capture"
	araignees.text = "Araignees\n" + str(global_save.get_value(global_save.save_paths["capture_cost"], "Araignees")) + " par capture"
	
	# Init pages
	initialise()
	
	# Init money
	global_money._on_coin_timer_timeout()
	if global_save.get_value(global_save.save_paths["money"], "Coins") == null:
		global_money.set_money(500)

func initialise():
	main_page.visible = true
	option_page.visible = false
	reset_page.visible = false
	places.visible = false
	reset_done_page.visible = false

func switch_to_camera(camera: Camera2D):
	# Disabled all cameras
	for cam in get_tree().get_nodes_in_group("Cameras"):
		cam.enabled = false
	
	# Enabled wanted camera
	camera.enabled = true

#endregion

#region Menu
func _on_capture_pressed():
	if places.visible:
		places.visible = false
	elif not places.visible:
		places.visible = true
	else:
		return "Capture button error"

func _on_right_pressed():
	pass
	
func _on_options_pressed():
	main_page.visible = false
	option_page.visible = true

func _on_quitter_pressed() -> void:
	get_tree().quit()
	
#endregion

#region creatures
func _on_cloportes_pressed() -> void:
	var capture_cloportes_value = global_save.get_value(global_save.save_paths["capture_cost"], "Cloportes")
	if global_save.get_value(global_save.save_paths["money"], "Coins", 0) <= capture_cloportes_value:
		pass
	else:
		switch_to_camera(camera_capture)
		global_money.remove_money(capture_cloportes_value)
		capture_cloportes_value += 5
		global_save.set_value(global_save.save_paths["capture_cost"], "Cloportes", capture_cloportes_value)

func _on_fourmis_pressed() -> void:
	pass
	#var capture_fourmis_value = global_save.get_value(global_save.save_paths["capture_cost"], "Fourmis")
	#if global_save.get_value(global_save.save_paths["money"], "Coins", 0) <= capture_fourmis_value:
		#pass
	#else:
		#switch_to_camera(camera_capture)
		#global_money.remove_money(capture_fourmis_value)
		#capture_fourmis_value += 5
		#global_save.set_value(global_save.save_paths["capture_cost"], "Fourmis", capture_fourmis_value)

func _on_iules_pressed() -> void:
	pass
	#var capture_iules_value = global_save.get_value(global_save.save_paths["capture_cost"], "Iules")
	#if global_save.get_value(global_save.save_paths["money"], "Coins", 0) <= capture_iules_value:
		#pass
	#else:
		#switch_to_camera(camera_capture)
		#global_money.remove_money(capture_iules_value)
		#capture_iules_value += 5
		#global_save.set_value(global_save.save_paths["capture_cost"], "Iules", capture_iules_value)

func _on_araignees_pressed() -> void:
	pass
	#var capture_araignees_value = global_save.get_value(global_save.save_paths["capture_cost"], "Araignees")
	#if global_save.get_value(global_save.save_paths["money"], "Coins", 0) <= capture_araignees_value:
		#pass
	#else:
		#switch_to_camera(camera_capture)
		#global_money.remove_money(capture_araignees_value)
		#capture_araignees_value += 5
		#global_save.set_value(global_save.save_paths["capture_cost"], "Araignees", capture_araignees_value)

#endregion
