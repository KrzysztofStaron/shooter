extends TextureRect

export var maxAmmo : int = 6
export var fill : Texture
var ammo : int setget ammoSetter

func ammoSetter(count : int):
	ammo = count
	var persent := 100.0 / maxAmmo * ammo
	var fillPersent : float = $fill.get_material().get_shader_param("persent")
	
	$Tween.stop_all()
	$Tween.interpolate_property($fill.get_material(), "shader_param/persent", fillPersent, persent, 0.2, Tween.TRANS_QUINT, Tween.EASE_IN)
	$Tween.start()
