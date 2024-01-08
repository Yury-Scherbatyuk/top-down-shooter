extends Node2D

func handle_bullet_spawned(bullet: Bullet, end_of_gun: Marker2D, direction: Vector2):
	add_child(bullet)
	bullet.global_position = end_of_gun.global_position
	bullet.global_rotation = end_of_gun.global_rotation
	bullet.set_direction(direction)
