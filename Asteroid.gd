extends RigidBody2D

var explosion = preload("res://Explosion.tscn")

onready var mainNode = get_node("/root/Main")

func _on_Asteroid_body_entered(body):
    if body.is_in_group("bullets"):
        mainNode.increment_score()
        body.queue_free()
        var explosionIns = explosion.instance()
        explosionIns.position = position
        mainNode.add_child(explosionIns)
        queue_free()
    elif body.is_in_group("player"):
        body.die()

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
