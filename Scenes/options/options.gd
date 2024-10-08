extends Node2D

@onready var res_slider = $res_slider
@onready var resolution_label = $resolution_label
@onready var select_sound = $select_sound

var key_array: Array[String] = ["300x300","600x600","800x800","1200x1200"]
var res: int = 800

func _on_res_slider_drag_ended(value_changed):
	print(res_slider.value)
	match res_slider.value:
		1.0:
			resolution_label.text = "300x300"
			res = 300
			pass
		2.0:
			resolution_label.text = "600x600"
			res = 600
			pass
		3.0:
			resolution_label.text = "800x800"
			res = 800
			pass
		4.0:
			resolution_label.text = "1200x1200"
			res = 1200
			pass
	pass


func _on_button_button_down():
	select_sound.play()
	pass

func _on_button_button_up():
	get_window().size = Vector2i(res, res)
	pass

func _on_back_btn_button_down():
	select_sound.play()
	pass

func _on_back_btn_button_up():
	SignalBus.progress_scene.emit(5)
	pass
