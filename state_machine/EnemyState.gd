class_name EnemyState
extends CharacterState

# Typed reference to the enemy node. Requires a script of class_name Enemy.
var enemy: Enemy


func _ready() -> void:
	# The states are children of the `Player` node so their `_ready()` callback will execute first.
	# That's why we wait for the `owner` to be ready first.
	await owner.ready
	
	enemy = owner as Enemy
	# This check will tell us if we inadvertently assign a derived state script
	# in a scene other than `Player.tscn`, which would be unintended. This can
	# help prevent some bugs that are difficult to understand.
	assert(enemy != null)
