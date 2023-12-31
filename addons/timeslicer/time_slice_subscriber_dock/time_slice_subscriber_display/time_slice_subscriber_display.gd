@tool
class_name TimeSliceSubscriberDisplay extends HBoxContainer


signal delete_slice(slice: String, method: String)


@onready var slice_name: Label = $SliceData/SliceName
@onready var method_name: Label = $SliceData/MethodName


var slice:String
var method:String


func _render(slice: String, method:String) -> void:
	print_debug("Setting display to %s: %s" % [slice, method])
	self.slice = slice
	self.method = method
	
	slice_name.text = "Slice Name: %s" % self.slice
	method_name.text = "Method Name: %s" % self.method


func _on_delete_button_pressed() -> void:
	delete_slice.emit(self.slice, self.method)
