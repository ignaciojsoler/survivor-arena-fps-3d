extends Area3D

const SPEED = 10
const RANGE = 40

var travelled_distance = 0

func _physics_process(delta: float) -> void:
	# Move the bullet
	self.position += -transform.basis.z * SPEED * delta
	
	# Increase and check travelled distance
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
