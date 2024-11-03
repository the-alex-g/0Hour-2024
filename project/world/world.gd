extends Node2D

var _score := 0
var _game_over := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EnemySpawner.target = $Player
	$EnemySpawner2.target = $Player


func _on_player_health_updated(new_health: int) -> void:
	$CanvasLayer/Control/ProgressBar.value = new_health
	if new_health == 0:
		_game_over = true
		$CanvasLayer/Control/Label2.visible = true


func _on_player_gained_point() -> void:
	if _game_over:
		return
	_score += 1
	$CanvasLayer/Control/Label.text = "%d points" % [_score]
