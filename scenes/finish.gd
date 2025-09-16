extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_tree().change_scene_to_file("res://scenes/Level2.tscn")  # Use the exact path
		const LEVEL_2 = preload("res://scenes/Level2.tscn")		
