extends Area2D
class_name Bullet

@export var speed = 700

@onready var bullet_destroy_timer = $BulletDestroyTimer

var direction := Vector2.ZERO

func _ready():
	bullet_destroy_timer.start()

func _process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed * delta
		
		global_position += velocity


func set_direction(input_direction: Vector2):
	self.direction = input_direction
	


func _on_timer_timeout():
	queue_free() # Replace with function body.
