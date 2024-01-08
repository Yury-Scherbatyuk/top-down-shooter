extends Node2D

signal weapon_fired(bullet: Bullet, end_of_gun_position: Vector2, direction: Vector2)

@export var Bullet_Scene: PackedScene 

@onready var end_of_gun = $EndOfGun
@onready var attack_cooldown = $AttackCooldown
@onready var animation_player = $AnimationPlayer

func shoot():
	if attack_cooldown.is_stopped() and Bullet != null:
		var bullet_instance = Bullet_Scene.instantiate()
		var direction_to_mouse = end_of_gun.global_position.direction_to(get_global_mouse_position()).normalized()
		emit_signal("weapon_fired", bullet_instance, end_of_gun, direction_to_mouse)
		attack_cooldown.start()
		animation_player.play("muzzle_flash")
