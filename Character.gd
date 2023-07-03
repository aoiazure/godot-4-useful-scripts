class_name Character
extends CharacterBody2D


@onready var movement: Movement = $Movement
@onready var stats: Stats = $Stats


var facing_right: bool = true

# Turn around
func flip():
	facing_right = !facing_right
	print("should be overwritten in %s" % self.name)


## Take damage; should be overwritten
func take_damage(data: DamageData) -> bool:
	var b: bool
	print("take_damage should be overwritten in %s" % self.name)
	print("%s takes %s damage" % [self.name, data.damage])
	return b



## Return if you can be damaged
func can_be_damaged() -> bool:
	var b: bool
	print("can_be_damaged should be overwritten in %s" % self.name)
	return b



## Can be knockedback
func can_be_knockedback() -> bool:
	var b: bool
	print("can_be_knockedback should be overwritten in %s" % self.name)
	return b


### GETTERS
## MOVEMENT
func get_speed() -> float:
	return (movement as Movement).speed_walk

func get_speed_run() -> float:
	return (movement as Movement).speed_run

func get_accel() -> float:
	return (movement as Movement).accel

func get_friction() -> float:
	return (movement as Movement).friction

func get_jump_height() -> float:
	return (movement as Movement).jump_velocity

func get_gravity() -> float:
	return (movement as Movement).gravity

func get_max_fall() -> float:
	return (movement as Movement).max_fall_speed

## STATS
func get_knockback_damping() -> Vector2:
	return (stats as Stats).knockback_damping

