extends Control

export var gameScene : PackedScene
export var settingScene : PackedScene

func _process(delta: float) -> void:
	if $AnimatedSprite.frame == 19:
		$audio.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to(gameScene)

func _on_settings_pressed() -> void:
	pass
