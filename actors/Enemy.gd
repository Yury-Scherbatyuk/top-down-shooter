extends CharacterBody2D

@onready var health_status = $Health
@onready var ai = $AI
@onready var weapon = $Weapon

func _ready():
	ai.initialize(self, weapon)

func handle_hit():
	health_status.health -= 20
	print("enemy hit", health_status.health)
	if health_status.health <= 0:
		queue_free()
