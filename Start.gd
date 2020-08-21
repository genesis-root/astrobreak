extends Node2D

func _input(event):
    if event is InputEventKey and event.pressed:
        if Input.is_action_pressed('quit'):
            get_tree().quit()
        else:
            get_tree().change_scene("res://Main.tscn")