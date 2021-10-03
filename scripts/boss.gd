extends Area2D

var type = "BOSS_CLOSED"
var player = null


var open_texture = preload("res://assets/boss_open.png")
var closed_texture = preload("res://assets/boss_closed.png")

var open_sprite = null
var closed_sprite = null
var timer = null
onready var active_sprite = get_node("boss_anim_spr")
onready var label = get_node("time_check")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.wait_time = 5
	timer.set_one_shot(false)
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)
	timer.start()
	
	open_sprite = Sprite.new()
	open_sprite.centered = false
	open_sprite.texture = open_texture
	
	closed_sprite = Sprite.new()
	closed_sprite.centered = false
	closed_sprite.texture = closed_texture
	
	connect('body_entered', self, '_on_player_body_enter')
	connect('body_exited', self, '_on_player_body_exit')

	
	
func _physics_process(delta):
	if player:
		player.check_coll(type)
		
	label.text = str(int(timer.get_time_left()) + 1)
	
	if Globals.boss_health <= 0:
		get_tree().change_scene("res://scenes/end.tscn")

func _on_player_body_enter(body):
	if body.get_name() == 'player':
		player = body
		active_sprite.play("hurt")
		get_node("boss_player").play()
		
func _on_player_body_exit(body):
	if body.get_name() == 'player':
		play_correct_sprite()
		player.killing_boss = false
		get_node("boss_player").stop()
		player = null
			
func _on_timer_timeout():
	if type == "BOSS_CLOSED":
		type = "BOSS_OPEN"
	else:
		type = "BOSS_CLOSED"
	play_correct_sprite()

func play_correct_sprite():
	if type == "BOSS_OPEN":
		active_sprite.play("open")
	if type == "BOSS_CLOSED":
		active_sprite.play("closed")
