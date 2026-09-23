@tool
class_name AngularContainer extends Container

@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var min_angle: float = 0.0 :
	set(val):
		min_angle = val
		if val > max_angle:
			max_angle = val
		_sort_children()

@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var max_angle: float = 360.0 :
	set(val):
		max_angle = maxf(min_angle, val)
		_sort_children()

@export_range(-180.0, 180.0, 1.0, "radians_as_degrees") var offset_angle: float = 0.0 :
	set(val):
		offset_angle = val
		_sort_children()

@export_range(0.0, 100.0, 1.0, "or_greater") var radius: float = 100.0 :
	set(val):
		radius = val
		_sort_children()

@export var rotate_children: bool = false :
	set(val):
		rotate_children = val
		_sort_children()

@export var debug_draw: bool = false :
	set(val):
		debug_draw = val
		queue_redraw()

func _ready() -> void:
	sort_children.connect(_sort_children)

func _sort_children() -> void:
	var children: Array = get_children()
	children = children.filter(func(c): return c is Control and c.visible)

	var max_count: int = children.size()
	var i: int = 1

	var angle_arc: float = max_angle - min_angle
	# Minor offset to make it feel a bit better and use more of the space more effectively.
	var bonus_offset: int = 1 if angle_arc < (2 * PI) or max_count <= 1 else 0

	var angle_interval = angle_arc / (max_count + bonus_offset)

	for child: Control in children:
		# Apply rotation first, then move if rotating. Orders of operation matter for some reason.
		if rotate_children:
			_apply_position(child, angle_interval, i)
			_apply_rotation(child, child.global_position.direction_to(self.global_position).angle())
		else:
			_apply_rotation(child, 0)
			_apply_position(child, angle_interval, i)
		
		i += 1
	
	if debug_draw:
		queue_redraw()

func _apply_position(child: Control, angle_interval: float, index: int) -> void:
	var calculated_angle: float = (angle_interval * index) + offset_angle + min_angle
	var pos:= Vector2(radius, 0).rotated(calculated_angle)
	child.global_position = self.global_position + pos - child.size / 2.


func _apply_rotation(child: Control, angle_radian: float) -> void:
	child.rotation = angle_radian

func _draw() -> void:
	if debug_draw:
		draw_arc(Vector2.ZERO, radius, min_angle + offset_angle, max_angle + offset_angle, 48, Color.RED)
