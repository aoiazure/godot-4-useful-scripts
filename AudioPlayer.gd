class_name AudioPlayer
extends Node2D

## Exports an array of paths to audio player nodes. Once the bug gets fixed, you can do Array[AudioStreamPlayer2D] directly.
@export var audio_players: Array[NodePath]

## Actually holds the audio node references.
var players: Array[AudioStreamPlayer2D]


func _ready():
	for c in audio_players:
		players.append(get_node(c))


## Returns an open audio player.
func get_open_player() -> AudioStreamPlayer2D:
	var p: AudioStreamPlayer2D
	
	for c in players:
		if not c.playing:
			p = c
			break
	
	return p

## Play a specified AudioStream on an open audio player.
func play_sound(a: AudioStream) -> void:
	var p: = get_open_player()
	p.stream = a
	p.play()


