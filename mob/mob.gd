extends RigidBody3D

@onready var bat_model: Node3D = %bat_model
@onready var player: CharacterBody3D = get_node("/root/Game/Player")

var speed = randf_range(2.0, 4.0)


func _physics_process(_delta: float) -> void:
	# Returns a normalized Vector3 pointing from the bat's position
	# toward the player's position.
	var direction = global_position.direction_to(player.global_position)

	# Ignore the vertical component so the bat only moves on the XZ plane.
	direction.y = 0

	# A normalized direction multiplied by a scalar speed produces
	# a velocity vector with the desired direction and magnitude.
	linear_velocity = direction * speed

	# Calculates the signed angle from FORWARD (-Z) to direction,
	# using UP (Y) as the axis of rotation.
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI


func take_damage():
	bat_model.hurt()
