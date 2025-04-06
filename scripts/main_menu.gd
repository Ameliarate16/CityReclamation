extends Control


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/mainGame.tscn")


func _on_instructions_button_pressed():
	$StartButton.visible = false
	$InstructionsButton.visible = false
	$InstructionsPanel.visible = true


func _on_close_instructions_pressed():
	$StartButton.visible = true
	$InstructionsButton.visible = true
	$InstructionsPanel.visible = false
