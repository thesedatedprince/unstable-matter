extends Area2D


const TYPE = "GLASS"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect('body_entered', self, '_on_player_body_enter')

func _on_player_body_enter(body):
	if body.get_name() == 'player':
		if body.check_coll(TYPE):
			get_node("glass_player").play()
			get_node("glass_full_anim").play("shatter")
