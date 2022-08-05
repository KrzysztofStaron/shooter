extends KinematicBody2D

export var bullet : PackedScene
export var speed : float 
export var speedMultiplayer := 1.0

export var weapon : Resource
var oldWeapon : Resource

var animation
var lastAnimation

func reload():
	get_node("../GUI/vContainer/ammunition").reload()

func _process(_delta) -> void:
	if oldWeapon != weapon:
		if lastAnimation != null:
			lastAnimation.active = false

		animation = get_node(weapon.weaponName + "Anim")
		animation.active = true
		lastAnimation = animation
		animation = animation.get("parameters/playback")
		
		oldWeapon = weapon
	
	
	var mousePos := get_local_mouse_position()
	
	var angle := atan2(mousePos.y, mousePos.x) 
	angle = deg2rad(rad2deg(angle) + 90)
	rotate(angle)
		
	var dir : Vector2 = InputManager.vector("move_left", "move_right", "move_up", "move_down")
	match weapon.weaponName:
		"hand":
			move_and_slide(dir * speed * speedMultiplayer)
			
			if dir != Vector2.ZERO:
				animation.travel("walking")
			else:
				animation.travel("idle")
		"glock":
			move_and_slide(dir * speed * speedMultiplayer)
			
			if Input.is_action_just_pressed("shoot"):
				animation.travel("shoot")
			elif Input.is_action_just_pressed("reload"):
				print("reload")
				animation.travel("reload")
			elif dir != Vector2.ZERO:
				animation.travel("walking")
			else:
				animation.travel("idle")

func shoot():
	if get_node("../GUI/vContainer/ammunition").ammo < weapon.ammoPerShoot:
		return
	
	match weapon.weaponName:
		"hand":
			pass
		"glock":
			var newBullet = bullet.instance()
			newBullet.angle = get_global_rotation()
			newBullet.bullet = weapon.bullet
			newBullet.set_global_position($gunPos.get_global_position())
			
			get_parent().add_child(newBullet)
			get_node("../GUI/vContainer/ammunition").removeAmmo(weapon.ammoPerShoot)
