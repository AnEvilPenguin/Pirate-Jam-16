extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	# Add gravity from Area2D
	# This is cool, but probably too complex for my current plan
	velocity += get_gravity() * delta

	move_and_slide()