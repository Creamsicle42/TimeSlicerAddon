@tool
class_name TimeSliceComponent extends PanelContainer


## Acts as a visual representation of a timeslice in the editor pannel


@onready var slice_name_editor: LineEdit = %SliceNameEditor
@onready var calls_per_update: SpinBox = %CallsPerUpdate
@onready var update_type: OptionButton = %UpdateType


## Sets the visual state of the component
func set_state(slice_name: String, calls: int, type: int) -> void:
	%SliceNameEditor.text = slice_name
	%CallsPerUpdate.value = calls
	%UpdateType.select(type)


## Gets the visual state of the component
func get_state() -> Dictionary:
	return {
		"name": %SliceNameEditor.text,
		"calls": %CallsPerUpdate.value,
		"type": %UpdateType.selected
	}
