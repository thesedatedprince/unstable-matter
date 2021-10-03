extends KinematicBody2D


const FLIGHT_SPEED = 500
const FLIGHT_ACCEL = 100
const UP = Vector2(0, -1)

const TYPE = "VAC"

var velocity = Vector2()
var player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		velocity = global_position.direction_to(player.global_position)
		var collision = move_and_collide(velocity * FLIGHT_SPEED * delta)
		
		if collision:
			if collision.collider.name == 'player':
				if player.check_coll(TYPE):
					get_parent().get_node("enemy_player").play()
					queue_free()
