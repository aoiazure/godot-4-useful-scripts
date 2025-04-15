extends Node2D

const BUS_SFX = "SFX"
const BUS_MUSIC = "Music"
const BUS_UI = "UI"
const BUS_AMBIENT = "Ambient"

var SFX_BUS_INDEX: int
var MUSIC_BUS_INDEX: int
var UI_BUS_INDEX: int
var AMBIENT_BUS_INDEX: int

var _generic_audio_players: Dictionary[AudioStreamPlayer, bool] = {}
var _2d_audio_players: Dictionary[AudioStreamPlayer2D, bool] = {}
var _3d_audio_players: Dictionary[AudioStreamPlayer3D, bool] = {}

var current_sfx_volume: float = 0.5 : 
	set(val):
		current_sfx_volume = clampf(val, 0.0, 1.0)
		set_sfx_volume(current_sfx_volume)
var current_music_volume: float = 0.5 : 
	set(val):
		current_music_volume = clampf(val, 0.0, 1.0)
		set_music_volume(current_music_volume)

var music_player: AudioStreamPlayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	SFX_BUS_INDEX = AudioServer.get_bus_index(BUS_SFX)
	MUSIC_BUS_INDEX = AudioServer.get_bus_index(BUS_MUSIC)
	UI_BUS_INDEX = AudioServer.get_bus_index(BUS_UI)
	AMBIENT_BUS_INDEX = AudioServer.get_bus_index(BUS_AMBIENT)



func set_sfx_volume(level: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_INDEX, linear_to_db(level))

func set_music_volume(level: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_INDEX, linear_to_db(level))


func play_ui_sound(stream: AudioStream, pitch: float = 1.0) -> void:
	var player = get_generic_player(stream, pitch)
	player.bus = BUS_UI
	
	_generic_audio_players[player] = true
	player.play()

func play_sound_nonpositional(stream: AudioStream, pitch: float = 1.0) -> void:
	var player = get_generic_player(stream, pitch)
	player.bus = BUS_SFX
	
	_generic_audio_players[player] = true
	player.play()

func play_2d_sound(stream: AudioStream, position_global: Vector2, pitch: float = 1.0) -> void:
	var player = get_2d_player(stream, pitch)
	player.bus = BUS_SFX
	player.global_position = position_global
	
	_2d_audio_players[player] = true
	player.play()

func play_3d_sound(stream: AudioStream, position_global: Vector3, pitch: float = 1.0) -> void:
	var player = get_3d_player(stream, pitch)
	player.bus = BUS_SFX
	player.global_position = position_global

	_3d_audio_players[player] = true
	player.play()

func play_music(stream: AudioStream) -> void:
	if not music_player:
		music_player = AudioStreamPlayer.new()
		music_player.bus = BUS_MUSIC
		add_child(music_player)
	
	music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	music_player.stream = stream
	music_player.play()

func get_generic_player(stream: AudioStream, pitch: float) -> AudioStreamPlayer:
	if not _generic_audio_players.values().has(false):
		var player:= AudioStreamPlayer.new()
		player.stream = stream
		player.pitch_scale = pitch
		player.finished.connect(
			func():
				_generic_audio_players[player] = false
		)
		_generic_audio_players[player] = false
		add_child(player)
		return player
	
	for player: AudioStreamPlayer in _generic_audio_players:
		if _generic_audio_players[player] == false:
			player.stream = stream
			player.pitch_scale = pitch
			return player
	
	return null

func get_2d_player(stream: AudioStream, pitch: float) -> AudioStreamPlayer2D:
	if not _2d_audio_players.values().has(false):
		var player:= AudioStreamPlayer2D.new()
		player.stream = stream
		player.pitch_scale = pitch
		player.finished.connect(
			func():
				_2d_audio_players[player] = false
		)
		_2d_audio_players[player] = false
		add_child(player)
		return player
	
	for player: AudioStreamPlayer2D in _2d_audio_players:
		if _2d_audio_players[player] == false:
			player.stream = stream
			player.pitch_scale = pitch
			return player
	
	return null

func get_3d_player(stream: AudioStream, pitch: float) -> AudioStreamPlayer3D:
	if not _3d_audio_players.values().has(false):
		var player:= AudioStreamPlayer3D.new()
		player.stream = stream
		player.pitch_scale = pitch
		player.finished.connect(
			func():
				_3d_audio_players[player] = false
		)
		_3d_audio_players[player] = false
		add_child(player)
		return player
	
	for player: AudioStreamPlayer3D in _3d_audio_players:
		if _3d_audio_players[player] == false:
			player.stream = stream
			player.pitch_scale = pitch
			return player
	
	return null
