class_name Player
extends CharacterBody2D

const GRAVITY := 9.81

@export var speed := 200.0
@export var jump_strength := 200.0


func _physics_process(_delta: float) -> void:
	var movement := Input.get_axis("left", "right")
	
	velocity.x = movement * speed
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_strength
	
	move_and_slide()
