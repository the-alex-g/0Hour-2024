extends Node2D

var target : Player

var enemy_count := 0


func _on_timer_timeout() -> void:
	if enemy_count < 3:
		var enemy := preload("res://enemy/enemy.tscn").instantiate()
		enemy.global_position = global_position
		enemy.target = target
		get_parent().add_child(enemy)
		enemy_count += 1
		
		await enemy.tree_exited
		
		enemy_count -= 1
