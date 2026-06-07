extends CharacterBody2D
class_name Player

@export var speed: float = 300.0

func _physics_process(_delta: float) -> void:
	var inputVector = Input.get_vector("left", "right", "up", "down").normalized()

	var targetVelocity = inputVector * speed

	velocity = targetVelocity
	move_and_slide()
