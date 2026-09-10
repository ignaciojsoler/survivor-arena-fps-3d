extends Area3D

const SPEED = 20
const RANGE = 40

var travelled_distance = 0

func _physics_process(delta: float) -> void:
	# Move the bullet
	position += -transform.basis.z * SPEED * delta
	
	# Increase and check travelled distance
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()



func _on_body_entered(body: Node3D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
