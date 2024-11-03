class_name Projectile
extends Area2D

var target : Vector2 :
	set(value):
		target = value
		await get_tree().create_tween().tween_property(self, "global_position", target, 1.0).set_trans(Tween.TRANS_QUAD).finished
		queue_free()
