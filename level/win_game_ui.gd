extends Control

class_name GameUI

signal play_again

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _on_quit_btn_button_up():
	get_tree().quit()


func _on_play_again_btn_pressed():
	get_tree().reload_current_scene.call_deferred()
	play_again.emit()
