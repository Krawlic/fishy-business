extends Node2D

@onready var select_sound = $select_sound
@onready var catalogue_btn = $catalogue_btn
@onready var start_btn = $start_btn

func _ready():
	if(Global.unlocked_bonus):
		catalogue_btn.visible = true
		catalogue_btn.disabled = false
	start_btn.grab_focus()
	pass

func _on_option_btn_button_up():
	SignalBus.progress_scene.emit(9)
	pass

func _on_start_btn_button_up():
	SignalBus.progress_scene.emit(0)
	pass 

func _on_howtoplay_btn_button_up():
	SignalBus.progress_scene.emit(3)
	pass

func _on_howtoplay_btn_button_down():
	select_sound.play()
	pass 


func _on_start_btn_button_down():
	select_sound.play()
	pass 


func _on_option_btn_button_down():
	select_sound.play()
	pass


func _on_close_btn_button_up():
	get_tree().quit()


func _on_catalogue_btn_button_down():
	select_sound.play()
	pass


func _on_catalogue_btn_button_up():
	SignalBus.progress_scene.emit(7)
	pass
