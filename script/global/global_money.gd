extends Node2D

@onready var coins_label = get_tree().root.get_node("Main/Général/Main page/Main/Control/Main page/Money/Coins label")

var coins_per_sec: int = 0

func get_money() -> int:
	return GlobalSave.get_value(GlobalSave.save_paths["money"], "Coins", 0)

func set_money(amount: int):
	GlobalSave.set_value(GlobalSave.save_paths["money"], "Coins", amount)
	print("Coins: ", amount)

func add_money(quantity: int):
	set_money(get_money() + quantity)

func remove_money(quantity: int):
	set_money(max(get_money() - quantity, 0))

func _on_coin_timer_timeout() -> void:
	# Get total coins
	var total_coins = GlobalSave.get_value(GlobalSave.save_paths["money"], "Coins")
	# Get creatures infos
	var creature_data = GlobalSave.get_value(GlobalSave.save_paths["creature"])
	if creature_data.keys():
		var total_gain_per_sec = 0
		var creatures = get_tree().get_nodes_in_group("Creatures")
		for creature_name in creature_data.keys():
			if creature_data.has(creature_name):
				var creature_count = creature_data.get(creature_name)
				if creature_count != null:
					var gain_per_sec = 0
					for creature in creatures:
						if creature.name == creature_name:
							gain_per_sec = creature.coin_value * creature_count
					total_gain_per_sec += gain_per_sec
		# Update total coin
		total_coins += total_gain_per_sec
		GlobalSave.set_value(GlobalSave.save_paths["money"], "Coins", total_coins)
		
		# Mise à jour de l'UI
		coins_label = get_tree().root.get_node("Main/Général/Main page/Main/Control/Main page/Money/Coins label")
		coins_label.text = "Coins: " + str(total_coins) + "\nGain par sec: " + str(total_gain_per_sec)
