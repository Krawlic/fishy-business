extends Node2D

@onready var score_label = $gameover_screen/score_label
@onready var gameover_sound = $gameover_sound
@onready var select_sound = $select_sound
@onready var new_hiscore_unlock = $new_hiscore_unlock
@onready var mainmenu_btn = $mainmenu_btn

func _ready():
	gameover_sound.play()
	score_label.text = str(Global.score)
	mainmenu_btn.grab_focus()
	
	if(Global.score > Global.high_score):
		Global.high_score = Global.score
		new_hiscore_unlock.visible = true
		new_hiscore_unlock.play("default")
		
	Global.reset_all()
	
	pass

func _process(delta):
	pass

func _on_mainmenu_btn_button_down():
	select_sound.play()
	pass 
	
func _on_mainmenu_btn_button_up():
	if(Global.high_score >= Global.bonus_req_points and !Global.unlocked_bonus):
		Global.unlocked_bonus = true
		SignalBus.progress_scene.emit(6)
	else:
		SignalBus.progress_scene.emit(5)
	pass 
