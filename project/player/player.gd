class_name Player
extends CharacterBody2D

signal health_updated(new_health: int)
signal gained_point

const GRAVITY := 15

@export var speed := 200.0
@export var jump_strength := 200.0
@export var health := 100 :
	set(value):
		if value > 0:
			health = value
		else:
			health = 0
		health_updated.emit(health)

var _can_defend := true

@onready var _weapon : Area2D = $Weapon


func _physics_process(_delta: float) -> void:
	var movement := Input.get_axis("left", "right")
	
	velocity.x = movement * speed
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_strength
	
	var action := Input.get_vector("weapon_left", "weapon_right", "weapon_up", "weapon_down")
	
	if $Weapon/AnimatedSprite2D.animation == "defend":
		for area: Area2D in _weapon.get_overlapping_areas():
			if area is Projectile:
				area.queue_free()
				gained_point.emit()
	elif $Weapon/AnimatedSprite2D.animation == "attack":
		for body: PhysicsBody2D in _weapon.get_overlapping_bodies():
			if body is Enemy:
				body.queue_free()
				gained_point.emit()
				gained_point.emit()
	elif action != Vector2.ZERO:
		_weapon.rotation = action.angle()
		if Input.is_action_pressed("shift") and _can_defend:
			_defend()
		else:
			_attack()
	
	move_and_slide()


func _defend() -> void:
	$Weapon/AnimatedSprite2D.play("defend")
	_can_defend = false
	await get_tree().create_timer(1.5).timeout
	_can_defend = true


func _attack() -> void:
	$Weapon/AnimatedSprite2D.play("attack")


func _on_animated_sprite_2d_animation_finished() -> void:
	$Weapon/AnimatedSprite2D.play("default")


func _draw() -> void:
	draw_circle(Vector2.ZERO, 8, Color.BLACK)
