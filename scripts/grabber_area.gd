extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect('body_entered', self, '_on_player_body_enter')
	connect('body_exited', self, '_on_player_body_exit')

func _on_player_body_enter(body):
	if body.get_name() == 'player':
		get_parent().player = body
		
func _on_player_body_exit(body):
	if body.get_name() == 'player':
		get_parent().player = null
