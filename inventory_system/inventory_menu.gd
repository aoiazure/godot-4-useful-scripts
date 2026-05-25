class_name InventoryMenu extends Control

const SLOT_SCENE:= preload("uid://c7ktvxfcw3yn2")

signal item_use_requested(slot: InventorySlot)

@export var number_of_slots: int = 30
@export var _number_of_columns: int = 6

@export var hotbar_slots_container: Container
@export_group("References")
@export var grid_container: GridContainer
@export var cursor_item: InventorySlot
@export var hover_timer: Timer
@export_subgroup("Inspector")
@export var inspector_panel: Container
@export var title_label: Label
@export var desc_label: Label

var slots: Array[InventorySlot] = []
var hovered_slot: InventorySlot = null
var selected_slot: InventorySlot = null
var held_item: Item = null

@onready var empty_slots: int = number_of_slots

# 0 is always the cursor.
var _inventory_slot_offset: int = 1


func toggle() -> void:
	if not visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		show()
	else:
		hovered_slot = null
		selected_slot = null
		held_item = null

		cursor_item.hide()
		hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED



func add(item: Item) -> bool:
	for i in range(1, slots.size()):
		var slot: InventorySlot = slots[i]
		if slot.is_empty():
			slot.set_item(item)
			item.set_multiplayer_authority(get_multiplayer_authority())
			return true
	
	return false


func remove(item: Item) -> bool:
	for i in range(number_of_slots):
		var slot: InventorySlot = slots[i]
		if slot.is_empty():
			continue
		elif slot.get_item() == item:
			slot.set_item(null)
			return true
	
	return false

@rpc("any_peer", "call_local", "reliable")
func swap_slots(from_idx: int, to_idx: int) -> void:
	if multiplayer.get_remote_sender_id() != get_multiplayer_authority():
		return
	
	# print("[%s] Called on node %s by %s" % [multiplayer.get_unique_id(), get_multiplayer_authority(), multiplayer.get_remote_sender_id()])
	var from_slot: InventorySlot = slots[from_idx]
	var to_slot: InventorySlot = slots[to_idx]

	var from_empty: bool = from_slot.is_empty()
	var to_empty: bool = to_slot.is_empty()
	
	# Both empty
	if from_empty and to_empty:
		return
	# One empty and not the other
	elif from_empty and not to_empty:
		from_slot.set_item(to_slot.get_item())
		to_slot.set_item(null)
	elif not from_empty and to_empty:
		to_slot.set_item(from_slot.get_item())
		from_slot.set_item(null)
	# Both full, so swap
	else:
		var temp_item:= from_slot.get_item()
		from_slot.set_item(to_slot.get_item())
		to_slot.set_item(temp_item)






func _ready() -> void:
	slots.clear()
	slots.append(cursor_item)

	if is_instance_valid(hotbar_slots_container):
		for c in hotbar_slots_container.get_children():
			if c is InventorySlot:
				slots.append(c)
				c.index = _inventory_slot_offset
				_inventory_slot_offset += 1
	
	slots.resize(slots.size() + number_of_slots)
	grid_container.columns = _number_of_columns
	for i in range(number_of_slots):
		var slot: InventorySlot = SLOT_SCENE.instantiate()
		
		var index: int = i + _inventory_slot_offset
		slots[index] = slot
		slot.index = index
		grid_container.add_child(slot)
	
	_connect_slot_signals()
	cursor_item.hide()
	
	hover_timer.timeout.connect(_on_hover_timer_timeout)

func _connect_slot_signals() -> void:
	InventoryEventBus.inventory_slot_hovered.connect(
		func(slot: InventorySlot): 
			hovered_slot = slot
			hover_timer.start()
	)
	InventoryEventBus.inventory_slot_exited.connect(
		func(_slot: InventorySlot):
			hovered_slot = null
			inspector_panel.hide()
			hover_timer.stop()
	)
	InventoryEventBus.inventory_slot_selected.connect(_handle_slot_pressed)

func _handle_slot_pressed(slot: InventorySlot) -> void:
	if not visible:
		# Using from hand
		if not slot.is_empty():
			item_use_requested.emit(slot)
		return
	
	# Same slot
	if selected_slot == slot:
		_set_cursor(selected_slot, selected_slot.get_item())
		# Put item back into it, so we "cancel"
		if not cursor_item.visible:
			selected_slot = null
	# No slot or new slot
	else:
		selected_slot = slot
		_set_cursor(selected_slot, selected_slot.get_item())


func _set_cursor(from_slot: InventorySlot, _item: Item) -> void:
	if is_instance_valid(from_slot):
		swap_slots.rpc(from_slot.index, cursor_item.index)
	
	cursor_item.visible = not cursor_item.is_empty()


func _on_hover_timer_timeout() -> void:
	var item:= hovered_slot.get_item()
	if not is_instance_valid(item):
		return
	
	title_label.text = item.item_name
	desc_label.text = item.item_desc

	inspector_panel.show()

func _process(_delta: float) -> void:
	cursor_item.global_position = get_global_mouse_position() + Vector2.ONE * 16
