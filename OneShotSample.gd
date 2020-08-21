extends AudioStreamPlayer

func _on_OneShotSample_finished():
    queue_free()
