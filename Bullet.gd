extends KinematicBody2D

var direction = Vector2()
var speed = 2000

func _process(delta):
    move_and_collide(direction * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
