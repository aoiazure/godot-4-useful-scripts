class_name InputState extends Object

var just_pressed: bool
var pressed: bool
var just_released: bool

func _init(input_name: StringName) -> void:
	just_pressed = Input.is_action_just_pressed(input_name)
	pressed = Input.is_action_pressed(input_name)
	just_released = Input.is_action_just_released(input_name)
