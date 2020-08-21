extends Timer

func _on_deathCooldown_timeout():
    get_tree().change_scene("res://Start.tscn")
