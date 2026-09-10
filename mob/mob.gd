extends RigidBody3D

@onready var bat_model: Node3D = %bat_model
@onready var player: CharacterBody3D = get_node("/root/Game/Player")

var speed = randf_range(2.0, 4.0)

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	direction.y = 0
	
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI

func take_damage():
	bat_model.hurt()
