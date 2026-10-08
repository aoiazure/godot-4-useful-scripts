extends Node

var pool: Dictionary[StringName, Pool] = {}

func borrow(key: StringName) -> Object:
	return pool[key].get_object()

func return_object(key: StringName, object: Node) -> void:
	pool[key].accept_return(object)

class Pool extends RefCounted:
	var factory: Callable
	var pool: Dictionary[Object, bool] = {}

	func get_object() -> Object:
		if pool.values().has(true):
			var valid: Array = pool.keys().filter(func(o): return pool[o] == true)
			var object = valid.front()
			pool[object] = false
			return object
		
		var new_object = factory.call()
		pool[new_object] = false

		return new_object
	
	func accept_return(object) -> void:
		if object.is_inside_tree():
			object.get_parent().remove_child(object)
		pool[object] = true

	func _init(_factory, num_to_pool: int) -> void:
		if _factory is PackedScene:
			factory = func (): return _factory.instantiate()
		elif _factory is Callable:
			if _factory.is_valid():
				factory = _factory
		else:
			push_error("Invalid factory.")

		for i in range(num_to_pool):
			var object = factory.call()
			pool[object] = true
