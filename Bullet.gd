extends Area2D

@export var speed = 300

var direction := Vector2.ZERO

func _process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed * delta
		
		global_position += velocity


func set_direction(input_direction: Vector2):
	self.direction = input_direction
