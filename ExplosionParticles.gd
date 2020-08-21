extends Node2D

onready var ParticlesNode = get_node("CPUParticles2D")

func _ready():
    ParticlesNode.emitting = true

func _on_UnspawnTimer_timeout():
    queue_free()
