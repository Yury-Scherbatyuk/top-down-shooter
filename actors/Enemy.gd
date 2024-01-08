extends CharacterBody2D

@onready var health_status = $Health

func handle_hit():
	health_status.health -= 20
	print("enemy hit", health_status.health)
	if health_status.health <= 0:
		queue_free()
