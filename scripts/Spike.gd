extends Node2D

const Player = preload("res://scripts/Player.gd")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		print("TEST")
		player.kill()
