extends Node2D

var target : Player


func _on_timer_timeout() -> void:
	var enemy := preload("res://enemy/enemy.tscn").instantiate()
	enemy.global_position = global_position
	enemy.target = target
	get_parent().add_child(enemy)
