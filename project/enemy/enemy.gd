class_name Enemy
extends CharacterBody2D

@export var speed := 150.0
@export var cooldown_time := 1.5

var target : Player
var _can_attack := true

@onready var _cooldown_timer : Timer = $CooldownTimer


func _physics_process(_delta: float) -> void:
	if abs(target.position.x - position.x) > 100:
		if target.position.x < position.x:
			velocity.x = -speed
		else:
			velocity.x = speed
	else:
		velocity.x = 0
		if _can_attack:
			_attack()
	move_and_slide()


func _attack():
	_can_attack = false
	
	var projectile := preload("res://enemy/projectile.tscn").instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = global_position
	projectile.target = target.global_position
	
	_cooldown_timer.start(cooldown_time + randf() - 0.5)
	await _cooldown_timer.timeout
	_can_attack = true


func _draw() -> void:
	draw_circle(Vector2.ZERO, 8, Color.BLACK)
