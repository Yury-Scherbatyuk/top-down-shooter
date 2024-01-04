extends CharacterBody2D

@export var Bullet: PackedScene 
@export var speed: int = 300

@onready var end_of_gun = $EndOfGun

func get_input():
	look_at(get_global_mouse_position())
	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _physics_process(delta):
	get_input()
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("shoot"):
		shoot()


func shoot():
	var bullet_instance = Bullet.instantiate()
	add_child(bullet_instance)
	bullet_instance.global_position = end_of_gun.global_position
	var mouse_position = get_global_mouse_position()
	var direction_to_mouse = bullet_instance.global_position.direction_to(mouse_position).normalized()
	bullet_instance.set_direction(direction_to_mouse)
