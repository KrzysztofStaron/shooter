extends TextureRect

export var maxAmmo : int = 6
export var fill : Texture
var ammo : int setget ammoSetter

func ammoSetter(count : int):
	ammo = count
	generateTexture()
	
func generateTexture():
	var newFill : Image = fill.get_data()
	newFill.lock()
	
	# here you can specify texture height
	var yLimit := Vector2(1, newFill.get_height()-1)
	var dif := yLimit.y - yLimit.x
	var pixelsPerBullet := dif/maxAmmo
	yLimit.y -= pixelsPerBullet * ammo
	
	for y in range(yLimit.x, yLimit.y):
		for x in range(4, 10):
			newFill.set_pixel(x, y, Color(0, 0, 0, 0))
	
	var fillTexture : ImageTexture = ImageTexture.new()
	fillTexture.create_from_image(newFill, 0)
	
	$fill.texture = fillTexture
		
	
