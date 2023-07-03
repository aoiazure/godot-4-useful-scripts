class_name DamageData
extends Resource

## Range of damage this attack does.
@export var damage: Vector2i = Vector2i(1, 2)
## Knockback vector *relative* to the user. Based on ``transform.scale.x`` of the hitbox.
@export var knockback: Vector2 = Vector2.ZERO

## Amount of screenshake.
## X: strength; Y: Decay rate
@export var screenshake: Vector2 = Vector2(-1, -1)
## Amount of hitfreeze.
## X: timescale; Y: freeze amount
@export var hitfreeze: Vector2 = Vector2(-1, -1)
