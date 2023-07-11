@tool
class_name TimeSliceComponent extends PanelContainer


## Acts as a visual representation of a timeslice in the editor pannel


@onready var slice_name_editor: LineEdit = %SliceNameEditor
@onready var calls_per_update: SpinBox = %CallsPerUpdate
@onready var update_type: OptionButton = %UpdateType


## Sets the visual state of the component
func set_state(slice_name: String, calls: int, type: int) -> void:
	slice_name_editor.text = slice_name
	calls_per_update.value = calls
	update_type.select(type)


## Gets the visual state of the component
func get_state() -> Dictionary:
	return {
		"name": slice_name_editor.text,
		"calls": calls_per_update.value,
		"type": update_type.selected
	}


func _on_remove_component_button_pressed() -> void:
	queue_free()
