extends Node2D

@onready var screen = $screen

# Called when the node enters the scene tree for the first time.
func _ready():
	screen.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_screen_animation_finished():
	SignalBus.progress_scene.emit(1)
