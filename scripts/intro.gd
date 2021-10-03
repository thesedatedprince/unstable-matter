extends Node2D


var story2 = preload("res://assets/story2.png")
var story3 = preload("res://assets/story3.png")

onready var spr = get_node("story")

var stories = []

# Called when the node enters the scene tree for the first time.
func _ready():
	stories = [story2, story3]

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		if stories.size() > 0:
			spr.texture = stories.pop_front()
		else:
			get_tree().change_scene("res://scenes/level_1.tscn")
