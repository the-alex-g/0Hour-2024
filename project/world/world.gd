extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EnemySpawner.target = $Player
	$EnemySpawner2.target = $Player
