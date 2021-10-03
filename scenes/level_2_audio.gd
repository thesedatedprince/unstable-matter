extends AudioStreamPlayer2D


func _ready():
	if Globals.audio_position:
		play(Globals.audio_position)
	else:
		play()
