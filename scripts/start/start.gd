extends TextureButton

func _on_button_up() -> void:
	get_tree().change_scene_to_file("res://game/wwtbam.tscn")
