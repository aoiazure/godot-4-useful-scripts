class_name AttackData
extends Resource

@export var damage_data: DamageData


@export_group("Frame Data")
## X: start active frame, Y: end active frame. Both inclusive.
## a.k.a. when your hitboxes are actually active.
@export var active_frames: Vector2i = Vector2i(0, 1)
## When you can start cancelling/go into the next buffered move. Both inclusive.
## (-1, -1) means none
@export var cancel_frames: Vector2i = Vector2i(-1, -1)
## Frames in which you are invulnerable. Both inclusive.
## (-1, -1) means none
@export var invuln_frames: Vector2i = Vector2i(-1, -1)


