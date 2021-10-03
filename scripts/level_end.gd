extends Area2D


export var next_scene = "after_level_1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect('body_entered', self, '_on_player_body_enter')


func _on_player_body_enter(body):
	if body.get_name() == 'player':
		Globals.player_position = null
		Globals.audio_position = null
		get_tree().change_scene("res://scenes/%s" % next_scene)
