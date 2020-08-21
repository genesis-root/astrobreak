extends Timer

var asteroid = preload("res://Asteroid.tscn")

onready var mainNode = get_node("/root/Main")
onready var projectResolution=Vector2(
    ProjectSettings.get_setting("display/window/size/width"),
    ProjectSettings.get_setting("display/window/size/height"))
onready var projectResolutionHalved = projectResolution /2
onready var halfX = int(projectResolutionHalved.x)
onready var halfY = int(projectResolutionHalved.y)

var offset = 10
var maxSpeed = 500
var maxRotation = 5

func _on_AsteroidSpawner_timeout():
    var asteroidIns = asteroid.instance()

    # Select random spawn position outside screen (the asteroids actually are spawning partially visible, hope players wont notice)
    # One of the coordinate components must be outside resolution range, other may or may not be
    var rand_pos = Vector2()
    if (randi() % 2):
        rand_pos.x = halfX + ((halfX + randi() % offset) * pow(-1, randi() % 2))
        rand_pos.y = randi() % (int(projectResolution.y + offset * 2)) - offset
    else:
        rand_pos.x = randi() % (int(projectResolution.x + offset * 2)) - offset
        rand_pos.y = halfY + ((halfY + randi() % offset) * pow(-1, randi() % 2))
    asteroidIns.position = rand_pos

    # Target screen center
    asteroidIns.linear_velocity =  (projectResolutionHalved - asteroidIns.position).normalized() * (randi() % maxSpeed)

    asteroidIns.angular_velocity = randi() % maxRotation

    mainNode.add_child(asteroidIns)