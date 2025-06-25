extends Node2D

@onready var transition_sound = $Camera/transition_sound

const SPLASH_LOGO = preload("res://Scenes/splash_logo.tscn")
const STARTING = preload("res://Scenes/fishing/starting.tscn")
const OPTIONS = preload("res://Scenes/options/options.tscn")
const HOWTO = preload("res://Scenes/howto/howto.tscn")

const START_FISHING = preload("res://Scenes/fishing/start_fishing.tscn")
const FISHING = preload("res://Scenes/fishing/Fishing.tscn")

const CLEANING = preload("res://Scenes/cleaning/cleaning.tscn")

const SPEED_UP = preload("res://Scenes/fishing/speed_up.tscn")
const GAME_OVER = preload("res://Scenes/fishing/game_over.tscn")

const BONUS = preload("res://Scenes/bonus/bonus.tscn")
const BONUS_FEATURES = preload("res://Scenes/bonus/bonus_features.tscn")
const CATALOGUE = preload("res://Scenes/catalogue/catalogue.tscn")

func _ready():
	SignalBus.gameover_scene.connect(_gameover_scene)
	SignalBus.progress_scene.connect(_progress_scene)
	var splash_tmp = SPLASH_LOGO.instantiate()
	add_child(splash_tmp)
	pass

func _process(delta):
	pass

func _progress_scene(progress: int):
	transition_sound.pitch_scale = randf_range(0.5,1.5)
	match progress:
		0:
			transition_sound.play()
			get_tree().get_root().get_node("Main").get_child(1).queue_free()
			var fishing_tmp = START_FISHING.instantiate()
			add_child(fishing_tmp)
		1:
			transition_sound.play()
			get_tree().get_root().get_node("Main").get_child(1).queue_free()
			var fishing_tmp = FISHING.instantiate()
			add_child(fishing_tmp)
		2:
			#Cleaning Stage
			transition_sound.play()
			get_tree().get_root().get_node("Main").get_child(1).queue_free()
			var clean_tmp = CLEANING.instantiate()
			add_child(clean_tmp)
			pass
		3:
			#How To Play
			transition_sound.play()
			get_tree().get_root().get_node("Main").get_child(1).queue_free()
			var how_tmp = HOWTO.instantiate()
			add_child(how_tmp)
			pass
		4:
			transition_sound.play()
			get_tree().get_root().get_node("Main").get_child(1).queue_free()
			Global.round += 1
			var speed_tmp = SPEED_UP.instantiate()
			add_child(speed_tmp)
		5:
			transition_sound.play()
			get_tree().get_root().get_node("Main").get_child(1).queue_free()
			var starting_tmp = STARTING.instantiate()
			add_child(starting_tmp)
		6:
			transition_sound.play()
			get_tree().get_root().get_node("Main").get_child(1).queue_free()
			var bonus_tmp = BONUS.instantiate()
			add_child(bonus_tmp)
		7:
			#Bonus Features
			transition_sound.play()
			get_tree().get_root().get_node("Main").get_child(1).queue_free()
			var bonus_tmp = BONUS_FEATURES.instantiate()
			add_child(bonus_tmp)
			pass
		8:
			#Catalogue
			transition_sound.play()
			get_tree().get_root().get_node("Main").get_child(1).queue_free()
			var cat_tmp = CATALOGUE.instantiate()
			add_child(cat_tmp)
			pass
		9:
			#Options
			transition_sound.play()
			get_tree().get_root().get_node("Main").get_child(1).queue_free()
			var options_tmp = OPTIONS.instantiate()
			add_child(options_tmp)
			pass
	pass
	
func _gameover_scene():
	get_tree().get_root().get_node("Main").get_child(1).queue_free()
	var gameover_tmp = GAME_OVER.instantiate()
	add_child(gameover_tmp)
	pass
