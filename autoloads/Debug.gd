## A node that makes logging output more visually useful.
## Comes with functionality to disable freely.
extends Node

var active: bool = true


func log(logger_name: String, output: String) -> void:
	if not active:
		return
	
	print("[%s] %s: %s" % [
			Time.get_time_string_from_system(),
			logger_name, output
		]
	)

func error(logger_name: String, output: String) -> void:
	if not active:
		return
	
	push_error("[%s][ERROR] %s: %s" % [
			Time.get_time_string_from_system(),
			logger_name, output
		]
	)








