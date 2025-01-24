extends Node2D

var farm_creature_count = {}
var save_file = "res://misc/creature_save.json"

func _ready():
	load_json_file()

func load_json_file() -> void:
	# Check if the file exists
	if !FileAccess.file_exists(save_file):
		print("File doesn't find")
		return
	
	# Open the file for reading
	var file = FileAccess.open(save_file, FileAccess.READ)
	
	# Read the content of the file as text
	var json = file.get_as_text()
	var json_object = JSON.new()
	
	# Parse the JSON text
	var error = json_object.parse(json)
	if error != OK:
		print("Parsing error to JSON")
		return
	
	# Store the parsed data in the content dictionary
	var parsed_data = json_object.data
	
	# Get the 'Farm' data from the parsed JSON and assign it to farm_creature_count
	if parsed_data.has("Farm"):
		farm_creature_count = parsed_data["Farm"]
	else:
		print("'Farm' does not exist in JSON file.")

func update_json_file(creature: String, value: int) -> void:
	if farm_creature_count.has(creature):
		farm_creature_count[creature] += value
	else:
		farm_creature_count[creature] = value
	write_json_file(farm_creature_count)

func write_json_file(data: Dictionary) -> void:
	# Get dictionary
	var save_data = {}
	save_data["Farm"] = data
	
	# Open the file in write mode
	var file = FileAccess.open(save_file, FileAccess.ModeFlags.WRITE)
	
	if file:
		# Convert dictionary to JSON text
		var json_text = JSON.stringify(save_data, "\t") # Format with tabs
		# Write the JSON text to the file
		file.store_string(json_text)
		print("Data written to the file.")
	else:
		print("Failed to open or create the file.")

func reset_json_file() -> void:
	# Open the file in read mode to get the current data
	var file = FileAccess.open(save_file, FileAccess.ModeFlags.READ)
	if file:
		# Read the file's content as text
		var json_text = file.get_as_text()
		var json_object = JSON.new()
		var error = json_object.parse(json_text)
		
		if error != OK:
			print("JSON parsing error.")
			return
		
		# Get the data from the file
		var data = json_object.data
		
		# Check if "Farm" exists and reset its values to 0
		if data.has("Farm"):
			for key in data["Farm"].keys():
				data["Farm"][key] = 0
		else:
			# If "Farm" does not exist, create it with empty values
			data["Farm"] = {}
		
		# Open the file again in write mode to update it
		file = FileAccess.open(save_file, FileAccess.ModeFlags.WRITE)
		if file:
			# Convert the dictionary back to JSON and write it to the file
			var json_text_updated = JSON.stringify(data, "\t")
			file.store_string(json_text_updated)
			print("Data reset and written to the file.")
		else:
			print("Failed to open the file in write mode.")
	else:
		print("File not found or access error.")
