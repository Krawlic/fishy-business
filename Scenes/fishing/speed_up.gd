extends Node2D

@onready var screen = $screen

func _ready():
	screen.play("default")
	pass

func _process(delta):
	pass

func _on_screen_animation_finished():
	SignalBus.progress_scene.emit(1)
	pass
