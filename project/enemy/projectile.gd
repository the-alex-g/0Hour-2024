class_name Projectile
extends Area2D

var target : Vector2 :
	set(value):
		target = value
		await get_tree().create_tween().tween_property(self, "global_position", target, 1.0).set_trans(Tween.TRANS_QUAD).finished
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.health -= 5
		queue_free()


func _draw() -> void:
	draw_circle(Vector2.ZERO, 4, Color.ORANGE_RED)
