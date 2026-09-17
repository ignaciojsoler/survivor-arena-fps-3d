extends Node3D

@onready var label: Label = %"Score label"
@onready var time_left_label = %"Time Left label"

var player_score = 0
var time_left = 30

func _ready():
	time_left_label.text = "Time left: " + str(time_left)

func increase_score():
	player_score += 1
	label.text = "Score: " + str(player_score)
	
func do_poof(mob_global_position):
	const SMOKE_PUFF = preload("res://mob/smoke_puff/smoke_puff.tscn")
	var poof = SMOKE_PUFF.instantiate()
	add_child(poof)
	poof.global_position = mob_global_position

func _on_mob_spawner_3d_mob_spawned(mob: Mob) -> void:
	do_poof(mob.global_position)
	
	mob.defeated.connect(increase_score)

	mob.died.connect(func on_mob_died():
		do_poof(mob.global_position)
		)


func _on_kill_plane_body_entered(body: Node3D) -> void:
	if body is Player:
		get_tree().reload_current_scene.call_deferred()


func _on_timer_timeout():
	if time_left == 1:
		display_win_msg()
		
	time_left -= 1
	time_left_label.text = "Time left: " + str(time_left)

func display_win_msg():
	const WIN_GAME_UI = preload("res://level/win_game_ui.tscn")
	var ui: GameUI = WIN_GAME_UI.instantiate()
	ui.play_again.connect(func resume():
		get_tree().paused = false
		)
	add_child(ui)
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	
