extends Area2D

export var bullet : Resource
export var angle : float

func _ready() -> void:
	$Sprite.texture = bullet.texture
	set_global_rotation(angle)
	
func _process(delta: float) -> void:
	position += Vector2(0, -bullet.speed).rotated(angle) * delta

func _on_bullet_body_entered(body: Node) -> void:
	if body.has_method("takeDamage"):
		body.takeDamage(bullet.damage)
	
	queue_free()
