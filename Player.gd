extends KinematicBody2D

var bullet = preload("res://Bullet.tscn")
var gunSound = preload("res://GunSound.tscn")
var explosion = preload("res://Explosion.tscn")

onready var projectResolution=Vector2(
    ProjectSettings.get_setting("display/window/size/width"),
    ProjectSettings.get_setting("display/window/size/height"))
onready var shootCooldown = get_node("ShootCooldown")
onready var mainNode = get_node("/root/Main")
onready var visibilityNotifier = get_node("VisibilityNotifier")
onready var trail = get_node("Trail")

var baseSpeed = 250
var speed = baseSpeed
var boostSpeed = 800
var rotSpeed = 5
var bulletSpawnOffset = Vector2(0, -34)

func shoot():
    if shootCooldown.is_stopped():
        shootCooldown.start()

        # Bullet object
        var bulletIns = bullet.instance()
        bulletIns.position =  (position + bulletSpawnOffset.rotated(rotation))
        bulletIns.rotation = rotation
        bulletIns.direction = Vector2(0, -1).rotated(rotation)
        mainNode.add_child(bulletIns)

        # Gunshot sound
        var shootIns = gunSound.instance()
        mainNode.add_child(shootIns)

func process_input(delta):
    speed = baseSpeed
    var rotCW = Input.is_action_pressed('right')
    var rotCCW = Input.is_action_pressed('left')
    if rotCW and not rotCCW:
        rotate(rotSpeed * delta)
    elif rotCCW and not rotCW:
        rotate(-rotSpeed * delta)

    if Input.is_action_pressed('up'):
        speed = boostSpeed
    if Input.is_action_pressed('shoot'):
        shoot()

func _physics_process(delta):
    process_input(delta)
    move_and_collide(Vector2(0, -1).rotated(rotation) * speed * delta)

    # Wrap player movement around screen
    if not visibilityNotifier.is_on_screen():
        if position.x > projectResolution.x:
            position.x = 0
        elif position.x < 0:
            position.x = projectResolution.x
        if position.y > projectResolution.y:
            position.y = 0
        elif position.y < 0:
            position.y = projectResolution.y

func die():
    var explosionIns = explosion.instance()
    explosionIns.position = position
    mainNode.add_child(explosionIns)

    # Preserve trail for a bit
    var old_pos = trail.global_position
    remove_child(trail)
    get_tree().get_root().add_child(trail)
    trail.global_position = old_pos
    trail.emitting = false

    mainNode.end()
    queue_free()
    