@tool
extends EditorPlugin

const MAIN_PANNEL = preload("res://addons/timeslicer/main_screen/time_slicer_main_pannel.tscn")
const DOCK = preload("res://addons/timeslicer/time_slice_subscriber_dock/time_slice_subscriber_dock.tscn")
const TIME_SLICER_AUTOLOAD_NAME = "TimeSlicer"

var main_pannel_instance : TimeSlicerMainPannel
var dock_instance : TimeSliceSubscriberDock

func _enter_tree() -> void:
	# Instantiate main pannel
	main_pannel_instance = MAIN_PANNEL.instantiate()
	get_editor_interface().get_editor_main_screen().add_child(main_pannel_instance)
	_make_visible(false)
	main_pannel_instance.call_deferred("build_container")
	
	# Instantiate dock
	dock_instance = DOCK.instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UR, dock_instance)
	
	# Add autoloads
	add_autoload_singleton(TIME_SLICER_AUTOLOAD_NAME, "res://addons/timeslicer/time_slicer.gd")


func _exit_tree() -> void:
	# Remove main pannel
	if main_pannel_instance:
		main_pannel_instance.queue_free()
	
	# Remove Dock
	remove_control_from_docks(dock_instance)
	dock_instance.free()
	
	# Remove autoloads
	remove_autoload_singleton(TIME_SLICER_AUTOLOAD_NAME)


func _has_main_screen() -> bool:
	return true


func _make_visible(visible: bool) -> void:
	if main_pannel_instance:
		main_pannel_instance.visible = visible


func _get_plugin_name() -> String:
	return "TimeSlicer"


func _get_plugin_icon() -> Texture2D:
	return preload("res://addons/timeslicer/timeslicer_addon_icon.png")
