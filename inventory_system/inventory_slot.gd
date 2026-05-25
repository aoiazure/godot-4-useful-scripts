class_name InventorySlot extends Button

var index: int = 0
# var is_hovered: bool = false
var _item: Item

func set_item(item: Item) -> void:
	_item = item
	if is_instance_valid(_item):
		icon = _item.icon
	else:
		icon = null

func get_item() -> Item:
	return _item

func is_empty() -> bool:
	return not is_instance_valid(_item)

func _ready() -> void:
	mouse_entered.connect(
		func():
			InventoryEventBus.inventory_slot_hovered.emit(self)
	)
	mouse_exited.connect(
		func():
			InventoryEventBus.inventory_slot_exited.emit(self)
	)
	pressed.connect(
		func(): 
			InventoryEventBus.inventory_slot_selected.emit(self)
	)
