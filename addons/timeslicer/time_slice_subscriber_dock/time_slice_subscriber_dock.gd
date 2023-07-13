@tool
class_name TimeSliceSubscriberDock extends Control


const TIME_SLICE_DISPLAY = preload("res://addons/timeslicer/time_slice_subscriber_dock/time_slice_subscriber_display/time_slice_subscriber_display.tscn")



@onready var method_name_field: LineEdit = %MethodNameField
@onready var time_slice_name_field: LineEdit = %TimeSliceNameField
@onready var subscribe_time_slice_button: Button = $VBoxContainer/SubscribeTimeSliceButton
@onready var time_slice_subscription_panel: VBoxContainer = $VBoxContainer/PanelContainer/TimeSliceSubscriptionPanel


var selected_node : Node


func _on_editor_selection_changed(new_selection: EditorSelection) -> void:
	if new_selection.get_selected_nodes().size() != 1:
		selected_node = null
	else:
		selected_node = new_selection.get_selected_nodes()[0]
	update_pannel_visuals()


func clear_subscription_panel() -> void:
	for i in time_slice_subscription_panel.get_children():
		i.queue_free()


func build_subscription_panel() -> void:
	if selected_node == null: return
	
	var node_data = selected_node.get_meta("time_slice_data", {})
	
	for slice in node_data:
		for method in node_data[slice]:
			var sub:TimeSliceSubscriberDisplay = TIME_SLICE_DISPLAY.instantiate()
			time_slice_subscription_panel.add_child(sub)
			sub.call_deferred("_render", slice, method)
			sub.delete_slice.connect(remove_subscription)


func remove_subscription(slice: String, method: String) -> void:
	pass


func update_pannel_visuals() -> void:
	clear_subscription_panel()
	if selected_node == null:
		method_name_field.editable = false
		time_slice_name_field.editable = false
		subscribe_time_slice_button.disabled = true
	else:
		method_name_field.editable = true
		time_slice_name_field.editable = true
		subscribe_time_slice_button.disabled = false
		build_subscription_panel()


func _on_subscribe_time_slice_button_pressed() -> void:
	# Test if selected node exists
	if selected_node == null: return
	
	# Get data from interface
	var method_name = method_name_field.text
	var time_slice_name = time_slice_name_field.text
	
	# Get existing node metadata
	var node_metadata:Dictionary = selected_node.get_meta("time_slice_data", {})
	
	# Test to make sure metadata is valid
	if not node_metadata is Dictionary: 
		push_error("Node Metadata is invalid")
		return
	
	# Make sure node does not already have this method subscribed
	if node_metadata.get(time_slice_name, []).has(method_name):
		print_debug("Node already has method %s subscribed to %s" % [method_name, time_slice_name])
		return
	
	# Add method to metadata
	var slice_data = []
	if node_metadata.has(time_slice_name):
		slice_data = node_metadata[time_slice_name]
	slice_data.append(method_name)
	node_metadata[time_slice_name] = slice_data
	
	# Add node metadata and group if needed
	selected_node.set_meta("time_slice_data", node_metadata)
	if not selected_node.is_in_group("time_slice_subscribed"): selected_node.add_to_group("time_slice_subscribed")
