extends AudioStreamPlayer

var has_played = false

func _ready():
	if not has_played:
		play()
		has_played = true
