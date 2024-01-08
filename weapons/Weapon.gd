extends Node2D
class_name Weapon

@export var Bullet_Scene: PackedScene 

@onready var end_of_gun = $EndOfGun
@onready var attack_cooldown = $AttackCooldown
@onready var animation_player = $AnimationPlayer

func shoot():
	if attack_cooldown.is_stopped() and Bullet != null:
		var bullet_instance = Bullet_Scene.instantiate()
		var inaccuracy = randf_range(-0.05, 0.05)
		var direction = self.global_position.direction_to(end_of_gun.global_position).rotated(inaccuracy)

		GlobalSignals.emit_signal("bullet_fired", bullet_instance, end_of_gun, direction)
		attack_cooldown.start()
		animation_player.play("muzzle_flash")
