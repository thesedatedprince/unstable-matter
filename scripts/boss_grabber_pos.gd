extends Position2D


export var rotation_speed = PI / 2

var num_grabbers = 6
var dead_positions = []

onready var grabber = preload("res://scenes/components/boss_grabber.tscn")

var timer = null

func _process(delta):
	rotation += rotation_speed * delta
	
	if num_grabbers < 6 and not timer:
		timer = Timer.new()
		timer.wait_time = 0.5
		timer.set_one_shot(true)
		timer.connect("timeout", self, "_on_timer_timeout")
		add_child(timer)
		timer.start()

func _on_timer_timeout():
	var i = grabber.instance()
	i.position = dead_positions.pop_front()
	add_child(i)
	num_grabbers += 1
	timer.queue_free()
	timer = null
