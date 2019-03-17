extends Button

export(String) var scene_to_load = "res://menu/main/MainMenu.tscn" 
export(bool) var quit_game = false

func _on_MainMenuButton_pressed():
	if quit_game:
		get_tree().quit()
	get_tree().change_scene(scene_to_load)