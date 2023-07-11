@tool
class_name TimesliceDataReader

## Acts as a helper class for saving and loading of the timeslice config

## The default path for the location of the config file
const TIMESLICE_DATA_PATH = "res://addons/timeslicer/timeslice_data.cfg"


## Gets the config file to be used for creating timeslice data, creates one it it does not exist
## Returns the timeslice config file
static func get_timeslice_data_file() -> ConfigFile:
	var config := ConfigFile.new()
	
	# Try to laod timeslice data
	var error := config.load(TIMESLICE_DATA_PATH)
	
	# If data file does not exist, create it
	if error != OK:
		# Setup metadata section
		config.set_value("meta", "time_slices", [])
		
		# Save newly created config file
		config.save(TIMESLICE_DATA_PATH)
	
	# Return config file
	return config


## Saves the given config file to disk
## Returns an error
static func save_timeslice_data_file(config: ConfigFile) -> Error:
	# Make sure file is valid
	if not config.has_section("meta"):
		push_error("Warning, Timeslice Config file is invalid. Reason, does not have meta section")
		return ERR_INVALID_DATA
	if not config.has_section_key("meta", "time_slices"):
		push_error("Warning, Timeslice Config file is invalid. Reason, invalid meta section")
		return ERR_INVALID_DATA
	
	# Save file
	return config.save(TIMESLICE_DATA_PATH)
