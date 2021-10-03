extends Node2D


var story8 = preload("res://assets/story8.png")
var story9 = preload("res://assets/story9.png")
var story10 = preload("res://assets/story10.png")
var story11 = preload("res://assets/story11.png")

onready var spr = get_node("story")

var stories = []

# Called when the node enters the scene tree for the first time.
func _ready():
	stories = [story8,story9, story10, story11]

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		if stories.size() > 0:
			spr.texture = stories.pop_front()
		else:
			Globals.static = false
			get_tree().change_scene("res://scenes/level_1.tscn")
