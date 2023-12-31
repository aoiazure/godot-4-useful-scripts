class_name CameraWithShake
extends Camera2D

## Movement
@export var lean_to_mouse: bool = false
@export var camera_damping: float = 0.9


### SCREEN SHAKE

## How quickly to move through the noise
@export var NOISE_SHAKE_SPEED: float = 30.0
@export var NOISE_SWAY_SPEED: float = 1.0
## Noise returns values in the range (-1, 1)
## So this is how much to multiply the returned value by
@export var NOISE_SHAKE_STRENGTH: float = 20.0
@export var NOISE_SWAY_STRENGTH: float = 10.0
## The starting range of possible offsets using random values
@export var RANDOM_SHAKE_STRENGTH: float = 30.0
## Multiplier for lerping the shake strength to zero
@export var SHAKE_DECAY_RATE: float = 3.0

# variable decay
var decay_rate: float = SHAKE_DECAY_RATE

enum ShakeType {
	Random,
	Noise,
	Sway
}

@onready var noise: FastNoiseLite = FastNoiseLite.new()
# Used to keep track of where we are in the noise
# so that we can smoothly move through it
var noise_i: float = 0.0
@onready var rand = RandomNumberGenerator.new()
var shake_type: int = ShakeType.Random
var shake_strength: float = 0.0

func _ready() -> void:
	rand.randomize()
	# Randomize the generated noise
	noise.seed = rand.randi()
	# Period affects how quickly the noise changes values
	noise.frequency = 2
	
	Events.screen_shake.connect(apply_noise_shake)

	
func apply_random_shake() -> void:
	shake_strength = RANDOM_SHAKE_STRENGTH
	shake_type = ShakeType.Random
	
func apply_noise_shake(strength: float = NOISE_SHAKE_STRENGTH,
		decay: float = SHAKE_DECAY_RATE) -> void:
	shake_strength = strength
	shake_type = ShakeType.Noise
	decay_rate = decay
	
func apply_noise_sway() -> void:
	shake_type = ShakeType.Sway



func _process(delta: float) -> void:
	# Fade out the intensity over time
	shake_strength = lerp(shake_strength, 0.0, decay_rate * delta)
	
	var shake_offset: Vector2
	
	match shake_type:
		ShakeType.Random:
			shake_offset = get_random_offset()
		ShakeType.Noise:
			shake_offset = get_noise_offset(delta, NOISE_SHAKE_SPEED, shake_strength)
		ShakeType.Sway:
			shake_offset = get_noise_offset(delta, NOISE_SWAY_SPEED, NOISE_SWAY_STRENGTH)
	# Shake by adjusting camera.offset so we can move the camera around the level via its position
	self.offset.x = shake_offset.x
	self.offset.y = shake_offset.y
	
	# Camera easing towards mouse
	if lean_to_mouse:
		var mouse_pos: Vector2 = get_global_mouse_position()
		var dir = mouse_pos - self.global_position
		if dir.length() > 25.0:
			self.offset = lerp(offset, offset + camera_damping * dir, 0.1)
	


func get_noise_offset(delta: float, speed: float, strength: float) -> Vector2:
	noise_i += delta * speed
	# Set the x values of each call to 'get_noise_2d' to a different value
	# so that our x and y vectors will be reading from unrelated areas of noise
	return Vector2(
		noise.get_noise_2d(1, noise_i) * strength,
		noise.get_noise_2d(100, noise_i) * strength
	)


func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
