@tool
class_name TimeSliceSubscriberDock extends Control


@onready var method_name_field: LineEdit = %MethodNameField
@onready var time_slice_name_field: LineEdit = %TimeSliceNameField



func _on_editor_selection_changed(new_selection: EditorSelection) -> void:
	print_debug(new_selection.get_selected_nodes().size())


func _on_subscribe_time_slice_button_pressed() -> void:
	pass # Replace with function body.
