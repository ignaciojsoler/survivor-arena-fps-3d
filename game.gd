extends Node3D

@onready var label: Label = %Label

var player_score = 0

func increase_score():
	player_score += 1
	label.text = "Score: " + str(player_score)

func _on_mob_spawner_3d_mob_spawned(mob: Variant) -> void:
	mob.died.connect(increase_score)
