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
	# Open the file in write mode
	var file = FileAccess.open(save_file, FileAccess.ModeFlags.WRITE)
	
	if file:
		# Convert dictionary to JSON text
		var json_text = JSON.stringify(data, "\t") # Format with tabs
		# Write the JSON text to the file
		file.store_string(json_text)
		print("Data written to the file.")
	else:
		print("Failed to open or create the file.")
