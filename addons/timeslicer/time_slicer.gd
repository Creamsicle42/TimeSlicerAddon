extends Node

## Acts as the central controller for time slicing
##
## Creates a number of time slice threads at runtime based on predefiend thread data, and automatically 
## executes a predefined number of thos threads every process or physics process tick

# ENUMS
enum ThreadType {
	PROCESS,
	PHYSICS_PROCESS
}


# PRIVATE VARIABLES

## A dictionary containing all actual time slice threads, this is populated at runtime
var _time_slice_threads := {}


# PUBLIC METHODS

## Adds a method to a give thread.
## Returns true if succesful and false if the thread does not exist or if the method is incompatable.
func subscribe_method_to_thread(thread_name: String, method: Callable) -> bool:
	return true


## Removes a method from a given thread.
## Returns true if succesful and false if the thread doesn't exist, or if the given thread does not contain the given method.
func unsubscrie_method_from_thread(thread_name: String, method: Callable) -> bool:
	return true


# PRIVATE METHODS

func _create_time_slice_threads() -> void:
	pass


## Creates a time slice thread, this function is run on program startup
func _create_time_slice_thread(thread_name: String, thread_type: ThreadType, calls_per_update: int) -> void:
	pass


func _physics_tick_threads() -> void:
	pass


func _process_tick_methods() -> void:
	pass



class TimeSliceThread:
	
	var _calls_per_update: int
	var _update_type: ThreadType
	var _methods : Array[Callable]
	
	func _init(calls_per_update: int, update_type: ThreadType) -> void:
		_calls_per_update = calls_per_update
		_update_type = update_type
		_methods = []
	
	
	func is_update_type(update_type: ThreadType) -> bool:
		return _update_type == update_type
	
	
	func preform_update() -> void:
		pass
	
	
	func subscribe_method(method: Callable) -> void:
		_methods.append(method)
	
	
	func unsubscribe_method(method: Callable) -> bool:
		if not _methods.has(method): return false
		_methods.erase(method)
		return true
