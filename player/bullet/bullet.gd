extends Area2D

export var bullet : Resource
export var angle : float
onready var particlesScene := preload("res://player/bullet/particles.tscn")

func _ready() -> void:
	$Sprite.texture = bullet.texture
	set_global_rotation(angle)
	
func _physics_process(delta: float) -> void:
	position += Vector2(0, -bullet.speed).rotated(angle) * delta

func _on_bullet_body_entered(body: Node) -> void:
	if body.has_method("takeDamage"):
		body.takeDamage(bullet.damage)
	
	var effect := particlesScene.instance()
	print(body.type)
	match body.type:
		"stone":
			effect.frames = bullet.hitStone
		"wood":
			effect.frames = bullet.hitWood
		"enemie":
			effect.frames = bullet.hitEnemie

	effect.set_global_position(get_global_position())
	effect.set_rotation(get_rotation())
	get_parent().add_child(effect)
	queue_free()
