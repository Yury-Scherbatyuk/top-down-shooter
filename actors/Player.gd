extends CharacterBody2D

signal player_fired_bullet(bullet: Bullet, end_of_gun: Marker2D, direction: Vector2)

@export var speed: int = 10000

@onready var weapon = $Weapon
@onready var health_status = $Health

func _ready():
	weapon.connect("weapon_fired", shoot)


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
		

func shoot(bullet: Bullet, end_of_gun: Marker2D, direction: Vector2):
	emit_signal("player_fired_bullet", bullet, end_of_gun, direction)


func handle_hit():
	health_status.health -= 20
	queue_free()
