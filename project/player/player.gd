class_name Player
extends CharacterBody2D

const GRAVITY := 15

@export var speed := 200.0
@export var jump_strength := 200.0
@export var health := 100.0

@onready var _weapon : Area2D = $Weapon


func _physics_process(_delta: float) -> void:
	var movement := Input.get_axis("left", "right")
	
	velocity.x = movement * speed
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_strength
	
	var action := Input.get_vector("weapon_left", "weapon_right", "weapon_up", "weapon_down")
	if action != Vector2.ZERO:
		_weapon.rotation = action.angle()
		if $Weapon/AnimatedSprite2D.animation == "default":
			if Input.is_action_pressed("shift"):
				_defend()
			else:
				_attack()
	
	move_and_slide()


func _defend() -> void:
	$Weapon/AnimatedSprite2D.play("defend")
	for area: Area2D in _weapon.get_overlapping_areas():
		if area is Projectile:
			area.queue_free()


func _attack() -> void:
	$Weapon/AnimatedSprite2D.play("attack")
	for body: PhysicsBody2D in _weapon.get_overlapping_bodies():
		if body is Enemy:
			body.queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	$Weapon/AnimatedSprite2D.play("default")
