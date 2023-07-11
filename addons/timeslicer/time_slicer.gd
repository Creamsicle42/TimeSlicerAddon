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

# PUBLIC VARIABLES

## A dictionary containing the data for all time slice threads
var time_slice_thread_data := {}

# PRIVATE VARIABLES

## A dictionary containing all actual time slice threads, this is populated at runtime
var _time_slice_threads := {}


func create_time_slice_thread_data() -> void:
	pass


# PRIVATE METHODS

## Creates a time slice thread, this function is run on program startup
func _create_time_slice_thread(thread_name: String) -> void:
	pass
