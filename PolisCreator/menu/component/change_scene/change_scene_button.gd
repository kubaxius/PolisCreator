extends Button

export(String) var scene_to_load = "res://menu/main/MainMenu.tscn" 

func _on_MainMenuButton_pressed():
	get_tree().change_scene(scene_to_load)