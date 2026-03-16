## Returns whether an operation succeeded, with optionally data attached.
class_name Result extends RefCounted

var success: bool = false
var data = null

static func Fail(error) -> Result:
	var result:= Result.new(false, error)
	return result

static func Success(_data = null) -> Result:
	var result:= Result.new(true, _data)
	return result

func _init(_success: bool, _data = null) -> void:
	success = _success
	data = _data
