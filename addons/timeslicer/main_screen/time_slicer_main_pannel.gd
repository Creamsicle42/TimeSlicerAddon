@tool
class_name TimeSlicerMainPannel extends Control


const TIME_SLICE_COMPONENT := preload("res://addons/timeslicer/main_screen/time_slice_component/time_slice_component.tscn")


@onready var time_slice_component_container: VBoxContainer = %TimeSliceComponentContainer


func clear_container() -> void:
	for i in time_slice_component_container.get_children():
		i.queue_free()


func build_container() -> void:
	print_debug("Building slice editor pannel 4")
	
	# Destroy all existing components
	clear_container()
	
	# Get config file
	var config_file := TimesliceDataReader.get_timeslice_data_file()
	
	# Build config screen
	var slice_ids :Array= (config_file.get_value("meta", "time_slices", []) as Array[String]) 
	for i in slice_ids:
		var slice_component :TimeSliceComponent= TIME_SLICE_COMPONENT.instantiate()
		var calls = config_file.get_value(i, "calls_per_tick", 1)
		var update_type = config_file.get_value(i, "tick_type", 0)
		slice_component.set_state(i, calls, update_type)
		time_slice_component_container.add_child(slice_component)



## Save the config file
func _on_save_button_pressed() -> void:
	# Create new config
	var new_config :ConfigFile= ConfigFile.new()
	
	# Get the data from all config elements
	var config_data := []
	for i in time_slice_component_container.get_children():
		if not i is TimeSliceComponent: continue
		config_data.append((i as TimeSliceComponent).get_state())
	
	# Build body of config file
	var slice_names := []
	for i in config_data:
		# Extract data
		var name :String= i.name
		var calls :int= i.calls
		var type :int= i.type
		
		# Add name to name list
		slice_names.append(name)
		
		# Add data to config
		new_config.set_value(name, "calls_per_tick", calls)
		new_config.set_value(name, "tick_type", type)
	
	# Add name list to config file
	new_config.set_value("meta", "time_slices", slice_names)
	
	# Save config
	var error := TimesliceDataReader.save_timeslice_data_file(new_config)
	
	# Print error if any occoured
	if error != OK:
		push_error(error)








