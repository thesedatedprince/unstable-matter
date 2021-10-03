extends KinematicBody2D

const FLIGHT_SPEED = 700
const FLIGHT_ACCEL = 100
const EXTRA_ACCEL = 300
const EXTRA_SPEED = 900
const UP = Vector2(0, -1)

var velocity = Vector2()
var state = "SOLID"
var killing_boss = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.player_position:
		position = Globals.player_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	
	var speed = FLIGHT_SPEED
	var accel = FLIGHT_ACCEL
	var slowdown_y = false
	var slowdown_x = false
	
	if Input.is_action_pressed("ui_change"):
		state = "GAS"
		get_node("player_animations").play("to_gas")
	else:
		state = "SOLID"
		get_node("player_animations").play("to_solid")
	
	if not Globals.static:
		velocity.x = min(velocity.x + accel, speed)

	if Input.is_action_pressed("ui_right"):
		if not Globals.static:
			velocity.x = min(velocity.x + EXTRA_ACCEL, EXTRA_SPEED)
		else:
			velocity.x = min(velocity.x + accel, speed)
	elif Input.is_action_pressed("ui_left"):
		if not Globals.static:
			velocity.x = min(velocity.x + 50, 500)
		else:
			velocity.x = max(velocity.x - accel, -speed)
	else:
		if Globals.static:
			slowdown_x = true

	if Input.is_action_pressed("ui_down"):
		velocity.y = min(velocity.y+accel, speed)
	elif Input.is_action_pressed("ui_up"):
		velocity.y = max(velocity.y-accel, -speed)
	else:
		slowdown_y = true
	
	if slowdown_y == true:
		velocity.y = lerp(velocity.y, 0, 0.4)
			
	if slowdown_x == true:
		velocity.x = lerp(velocity.x, 0, 0.7)
	
	if is_on_wall() and not Globals.static:
		handle_death()
		
	if killing_boss:
		Globals.boss_health -= 1
	
	velocity = move_and_slide(velocity, UP)


func check_coll(type):
	if type == "GLASS" and state == "GAS":
		handle_death()
	if type == "GRID" and state == "SOLID":
		handle_death()
	if type == "GLASS" and state == "SOLID":
		return true
	if type == "GRID" and state == "GAS":
		return true
		
	if type == "GRABBER" and state == "SOLID":
		handle_death()
	
	if type == "GRABBER" and state == "GAS":
		return true
		
	if type == "VAC" and state == "GAS":
		handle_death()
		
	if type == "VAC" and state == "SOLID":
		return true
		
	if type == "BOSS_CLOSED":
		handle_death()
		
	if type == "BOSS_OPEN" and state == "SOLID":
		handle_death()
		
	if type == "BOSS_OPEN" and state == "GAS":
		killing_boss = true
		
	if type == "CHECKPOINT":
		handle_save()
		return true
		
func handle_death():
	Globals.boss_health = 1000
	Globals.static = false
	Globals.audio_position = get_parent().get_node("level_one_audio").get_playback_position()
	get_node("player_dead").play()
	_restart_level()

func handle_save():
	Globals.player_position = self.position
	
func _restart_level():
	get_tree().reload_current_scene()
