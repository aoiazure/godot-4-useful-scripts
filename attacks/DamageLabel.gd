class_name DamageLabel
extends CharacterBody2D

@export var decay_time: float = 0.6

@onready var damage: Label = $Damage

var GRAVITY = 700

func _ready():
	# Decay
	var timer = get_tree().create_timer(decay_time)
	timer.timeout.connect(queue_free)
	
	# change motion
	randomize()
	velocity.x = randf_range(-1, 1) * 50
	velocity.y = randf_range(-20, 20) - 200
	
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate:a", 0, decay_time)
	tween.play()

	
func _physics_process(delta):
	apply_gravity(delta)
	move_and_slide()

func apply_gravity(delta):
	velocity.y += GRAVITY * delta

func set_text(value: float):
	damage.text = "%.1f" % value
	
	if value >= 50.0:
		self.scale *= 2.0
	elif value > 10.0:
		self.scale *= 1.5
	
	
	
