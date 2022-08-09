extends KinematicBody2D

export var bullet : PackedScene
export var speed : float 
export var speedMultiplayer := 1.0

export var gunRised := false 

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
			
			if Input.is_action_just_pressed("grab"):
				gunRised = !gunRised
				
			if Input.is_action_just_pressed("shoot") and gunRised:
				animation.travel("shoot")
			elif Input.is_action_just_pressed("reload"):
				gunRised = true
				print("reload")
				animation.travel("reload")
			elif dir != Vector2.ZERO:
				if !gunRised:
					set_rotation(atan2(dir.x, -dir.y))
					animation.travel("walking")
				else:
					animation.travel("walkingRised")
					
			else:
				if gunRised:
					animation.travel("idleRised")
				else:
					animation.travel("idle")
	
	var angle := atan2(mousePos.y, mousePos.x) 
	
	if gunRised:
		angle += deg2rad(90)
		rotate(angle)

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
