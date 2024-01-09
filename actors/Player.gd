extends CharacterBody2D

@export var speed: int = 10000

@onready var weapon = $Weapon
@onready var health_status = $Health

func get_input(delta: float):
	look_at(get_global_mouse_position())
	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta


func _physics_process(delta: float):
	get_input(delta)
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("shoot"):
		weapon.shoot()


func handle_hit():
	health_status.health -= 20
	# if health_status.health <= 0:
	# 	queue_free()
