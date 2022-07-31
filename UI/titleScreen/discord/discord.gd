extends TextureButton

func _onClick():
	OS.shell_open(ProjectSettings.get_setting("Config/socials/discord/link"))
