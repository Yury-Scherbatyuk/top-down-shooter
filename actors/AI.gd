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

func _process(delta):
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null and weapon != null:
				actor.rotation = actor.global_position.direction_to(player.global_position).angle()
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
