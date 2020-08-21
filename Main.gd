extends Node2D

onready var toggleSFXCooldown = get_node("ToggleSFXCooldown")
onready var toggleMusicCooldown = get_node("ToggleMusicCooldown")
onready var scoreNode = get_node("Score")
onready var deathCooldown = get_node("DeathCooldown")
onready var musicPlayer = get_node("MusicPlayer")
onready var asteroidSpawner= get_node("AsteroidSpawner")

var score = 0
enum {MASTER_BUS, SFX_BUS, MUSIC_BUS}

func toggleAudioBus(cooldownTimer, busIdx):
    if cooldownTimer.is_stopped():
        AudioServer.set_bus_mute(busIdx, !AudioServer.is_bus_mute(busIdx))
        cooldownTimer.start()

func _process(delta):
    if Input.is_action_pressed('quit'):
        get_tree().quit()
    if Input.is_action_pressed('toggle_sfx'):
        toggleAudioBus(toggleSFXCooldown, SFX_BUS)
    if Input.is_action_pressed('toggle_music'):
        toggleAudioBus(toggleMusicCooldown, MUSIC_BUS)

func increment_score():
    score += 1
    asteroidSpawner.wait_time = 1.5 - (score / 5) * .1 # Difficulty increase

func end():
    scoreNode.text = "Score: " + str(score)
    scoreNode.visible = true
    musicPlayer.pitch_scale = 0.5
    deathCooldown.start() # Goes back to main menu after cooldown period
