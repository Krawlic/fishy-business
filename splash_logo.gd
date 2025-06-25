extends Node2D

@onready var jingle_sound = $jingle_sound
@onready var logo = $logo

# Called when the node enters the scene tree for the first time.
func _ready():
	logo.play("default")
	jingle_sound.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_logo_animation_finished():
	SignalBus.progress_scene.emit(5)
	pass # Replace with function body.
