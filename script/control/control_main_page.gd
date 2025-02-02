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

# Labels & buttons
@onready var coins_label: Label = $"Money/Coins label"
@onready var cloportes: Button = $Places/Cloportes
@onready var fourmis: Button = $Places/Fourmis
@onready var iules: Button = $Places/Iules
@onready var araignees: Button = $"Places/Araignees"
@onready var rejouer: Button = $"../../../../Capture/Control/Game end page/Menu/Rejouer"
@onready var right: Button = $"Move right/Right"

#endregion

#region Game
func _ready() -> void:
	# Init family cost
	if not GlobalSave.get_value(GlobalSave.save_paths["capture_cost"], "Cloportes"):
		GlobalCaptureCost._ready()
	cloportes.text = "Cloportes\n" + str(GlobalSave.get_value(GlobalSave.save_paths["capture_cost"], "Cloportes")) + " par capture"
	fourmis.text = "Fourmis\n" + str(GlobalSave.get_value(GlobalSave.save_paths["capture_cost"], "Fourmis")) + " par capture"
	iules.text = "Iules\n" + str(GlobalSave.get_value(GlobalSave.save_paths["capture_cost"], "Iules")) + " par capture"
	araignees.text = "Araignees\n" + str(GlobalSave.get_value(GlobalSave.save_paths["capture_cost"], "Araignees")) + " par capture"

	# Init pages
	initialise()

	# Init Terrarium
	GlobalTerrarium.get_cameras()

	# Init money
	GlobalMoney._on_coin_timer_timeout()
	if GlobalSave.get_value(GlobalSave.save_paths["money"], "Coins") == null:
		GlobalMoney.set_money(500)

func initialise():
	main_page.visible = true
	option_page.visible = false
	reset_page.visible = false
	places.visible = false
	reset_done_page.visible = false

#endregion

#region Menu
func _on_capture_pressed():
	if places.visible:
		places.visible = false
		right.visible = true
	elif not places.visible:
		places.visible = true
		right.visible = false
	else:
		return "Capture button error"

func _on_options_pressed():
	main_page.visible = false
	option_page.visible = true

func _on_quitter_pressed() -> void:
	get_tree().quit()

#endregion

#region creatures
func _on_cloportes_pressed() -> void:
	var capture_cloportes_value = GlobalSave.get_value(GlobalSave.save_paths["capture_cost"], "Cloportes")
	if GlobalSave.get_value(GlobalSave.save_paths["money"], "Coins", 0) <= capture_cloportes_value:
		rejouer.visible = false
	else:
		rejouer.visible = true
		camera_capture.make_current()
		GlobalMoney.remove_money(capture_cloportes_value)
		capture_cloportes_value += 5
		GlobalSave.set_value(GlobalSave.save_paths["capture_cost"], "Cloportes", capture_cloportes_value)

func _on_fourmis_pressed() -> void:
	pass
	#var capture_fourmis_value = GlobalSave.get_value(GlobalSave.save_paths["capture_cost"], "Fourmis")
	#if GlobalSave.get_value(GlobalSave.save_paths["money"], "Coins", 0) <= capture_fourmis_value:
	#    pass
	#else:
	#    camera_capture.make_current()
	#    GlobalMoney.remove_money(capture_fourmis_value)
	#    capture_fourmis_value += 5
	#    GlobalSave.set_value(GlobalSave.save_paths["capture_cost"], "Fourmis", capture_fourmis_value)

func _on_iules_pressed() -> void:
	pass
	#var capture_iules_value = GlobalSave.get_value(GlobalSave.save_paths["capture_cost"], "Iules")
	#if GlobalSave.get_value(GlobalSave.save_paths["money"], "Coins", 0) <= capture_iules_value:
	#    pass
	#else:
	#    camera_capture.make_current()
	#    GlobalMoney.remove_money(capture_iules_value)
	#    capture_iules_value += 5
	#    GlobalSave.set_value(GlobalSave.save_paths["capture_cost"], "Iules", capture_iules_value)

func _on_araignees_pressed() -> void:
	pass
	#var capture_araignees_value = GlobalSave.get_value(GlobalSave.save_paths["capture_cost"], "Araignees")
	#if GlobalSave.get_value(GlobalSave.save_paths["money"], "Coins", 0) <= capture_araignees_value:
	#    pass
	#else:
	#    camera_capture.make_current()
	#    GlobalMoney.remove_money(capture_araignees_value)
	#    capture_araignees_value += 5
	#    GlobalSave.set_value(GlobalSave.save_paths["capture_cost"], "Araignees", capture_araignees_value)

	#endregion
