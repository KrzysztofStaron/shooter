extends AnimatedSprite

func _on_particles_animation_finished() -> void:
	queue_free()
