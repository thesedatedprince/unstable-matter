extends Area2D

const TYPE = "VAC"

var start_position = null

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = position
	connect('body_entered', self, '_on_player_body_enter')

func _on_player_body_enter(body):
	if body.get_name() == 'player':
		if body.check_coll(TYPE):
			var parent = get_parent()
			parent.num_grabbers -= 1
			
			parent.dead_positions.append(start_position)
			get_parent().get_parent().get_parent().get_node("enemy_player").play()
			queue_free()
