extends TextureButton

func _onClick():
	if OS.shell_open(ProjectSettings.get_setting("Config/socials/discord/link")):
		printerr("discord link cannot be loaded")
