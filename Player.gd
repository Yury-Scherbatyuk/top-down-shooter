extends CharacterBody2D

signal player_fired_bullet(bullet: Bullet, end_of_gun: Marker2D, direction: Vector2)

@export var Bullet_Scene: PackedScene 
@export var speed: int = 10000

@onready var end_of_gun = $EndOfGun

func get_input(delta: float):
	look_at(get_global_mouse_position())
	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta


func _physics_process(delta: float):
	get_input(delta)
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("shoot"):
		shoot()

func shoot():
	var bullet_instance = Bullet_Scene.instantiate()
	var direction_to_mouse = end_of_gun.global_position.direction_to(get_global_mouse_position()).normalized()
	
	emit_signal("player_fired_bullet", bullet_instance, end_of_gun, direction_to_mouse)
