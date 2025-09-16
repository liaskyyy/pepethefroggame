extends Node

@onready var points_label: Label = $"../UI/Panel/PointsLabel"

var points = 0
var total_apples = 0

func _ready():
	reset_points()

func add_point():
	points += 1
	points_label.text = "Point: " + str(points)
	if points >= total_apples:
		proceed_to_next_level()

func reset_points():
	points = 0
	points_label.text = "Point: 0"

func proceed_to_next_level():
	await get_tree().create_timer(1).timeout  # Optional delay
	get_tree().change_scene_to_file("res://Level2.tscn")  # Change this to your actual scene path
