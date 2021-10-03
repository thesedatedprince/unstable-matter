extends Area2D


func _ready():
	connect('body_entered', self, '_on_player_body_enter')

func _on_player_body_enter(body):
	if body.get_name() == 'player':
		Globals.static = true
		var camera = body.get_node("Camera2D")
		camera.limit_right = 4544
		camera.limit_left = 2688
		camera.limit_bottom = 1280
		self.queue_free()
