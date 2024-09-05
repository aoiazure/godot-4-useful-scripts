## AudioHandler. Primarily works in 2D at the moment.
extends Node2D

const BUS_SFX = "SFX"
const BUS_MUSIC = "Music"
const BUS_AMBIENT = "Ambient"
const BUS_UI = "UI"

var SFX_BUS_INDEX: int
var MUSIC_BUS_INDEX: int
var AMBIENT_BUS_INDEX: int
var UI_BUS_INDEX: int

var current_sfx_volume: float = 0.5 : 
	set(val):
		current_sfx_volume = clampf(val, 0.0, 1.0)
		set_sfx_volume(current_sfx_volume)
var current_music_volume: float = 0.5 : 
	set(val):
		current_music_volume = clampf(val, 0.0, 1.0)
		set_music_volume(current_music_volume)
		set_ambient_volume(current_music_volume)

var music_player: AudioStreamPlayer
var ambient_player: AudioStreamPlayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	SFX_BUS_INDEX = AudioServer.get_bus_index(BUS_SFX)
	MUSIC_BUS_INDEX = AudioServer.get_bus_index(BUS_MUSIC)
	AMBIENT_BUS_INDEX = AudioServer.get_bus_index(BUS_AMBIENT)
	
	set_sfx_volume(current_sfx_volume)
	set_music_volume(current_music_volume)



func set_sfx_volume(level: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_INDEX, linear_to_db(level))

func set_ui_volume(level: float) -> void:
	AudioServer.set_bus_volume_db(UI_BUS_INDEX, linear_to_db(level))

func set_music_volume(level: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_INDEX, linear_to_db(level))

func set_ambient_volume(level: float) -> void:
	AudioServer.set_bus_volume_db(AMBIENT_BUS_INDEX, linear_to_db(level))


func play_ui_sound(stream: AudioStream) -> void:
	var player = create_generic_player(stream, 1.0)
	player.bus = BUS_UI
	add_child(player)
	player.play()

func play_sound_nonpositional(stream: AudioStream, pitch: float = 1.0) -> void:
	var player = create_generic_player(stream, pitch)
	player.bus = BUS_SFX
	add_child(player)
	player.play()

func play_sound_2d_from_position(stream: AudioStream, position_global: Vector2, volume: float = 1.0) -> void:
	var player = AudioStreamPlayer2D.new()
	player.stream = stream
	player.bus = BUS_SFX
	player.volume_db = linear_to_db(volume)
	player.attenuation = 0.01
	add_child(player)
	player.global_position = position_global
	player.play()

func play_sound_3d_from_position(stream: AudioStream, position_global: Vector3, volume: float = 1.0) -> void:
	var player = AudioStreamPlayer3D.new()
	player.stream = stream
	player.bus = BUS_SFX
	player.volume_db = linear_to_db(volume)
	add_child(player)
	player.global_position = position_global
	player.play()

func create_generic_player(stream: AudioStream, pitch: float) -> AudioStreamPlayer:
	var player:= AudioStreamPlayer.new()
	player.stream = stream
	player.pitch_scale = pitch
	player.finished.connect(player.queue_free)
	return player

func play_music(stream: AudioStream) -> void:
	if not music_player:
		music_player = AudioStreamPlayer.new()
		music_player.bus = BUS_MUSIC
		add_child(music_player)
	
	music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	music_player.stream = stream
	music_player.play()

func play_ambient(stream: AudioStream) -> void:
	if not ambient_player:
		ambient_player = AudioStreamPlayer.new()
		ambient_player.bus = BUS_AMBIENT
		add_child(ambient_player)
	
	ambient_player.process_mode = Node.PROCESS_MODE_ALWAYS
	ambient_player.stream = stream
	ambient_player.play()
