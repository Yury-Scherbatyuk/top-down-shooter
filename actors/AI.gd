extends Node2D

signal state_changed(new_state)

enum State {
	PATROL,
	ENGAGE
}

@onready var player_detection_zone = $PlayerDetectionZone

var current_state: State = State.PATROL : set = set_state
var actor = null
var player = null
var weapon: Weapon = null

var actor_lerp_weight = 0.2
var aiming_ready = 0.99

func _physics_process(delta):
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null and weapon != null:
				#angle between enemy and player
				var angle_to_player = actor.global_position.direction_to(player.global_position).angle()
				#smothly turn enemy to player position
				actor.rotation = lerp_angle(actor.rotation, angle_to_player, actor_lerp_weight)
				#direction from enemy to player
				var direction_to_player = (player.global_position - actor.global_position).normalized()
				#enemy look vector based on current rotation angle
				var aiming_direction = Vector2(cos(actor.rotation), sin(actor.rotation))
				#compare player direction angle and current aiming direction
				var aiming_level = aiming_direction.dot(direction_to_player)

				if aiming_level >= aiming_ready:
					weapon.shoot()
			else:
				print("WARN: ENGAGE state, but no Player/Weapon")
		_:
			print("ERROR: state not exists")

func initialize(new_actor, new_weapon: Weapon):
	get_parent()
	self.actor = new_actor
	self.weapon = new_weapon


func set_state(new_state: State):
	if new_state == current_state:
		return
	current_state = new_state
	emit_signal("state_changed", current_state)


func _on_player_detection_zone_body_entered(body: Node2D):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body


func _on_player_detection_zone_body_exited(body:Node2D):
	if player and body == player:
		set_state(State.PATROL)
		player = null
