extends Node2D

@onready var background = $background
@onready var alert_img = $alert_img
@onready var engine = $engine
@onready var sid = $sid
@onready var left_pole = $left_pole
@onready var right_pole = $right_pole
@onready var key_container = $key_container
@onready var progress_bar = $ProgressBar
@onready var game_timer = $ProgressBar/game_timer
@onready var catch_window = $catch_window
@onready var success_timer = $success_timer
@onready var catch_sound = $catch_sound
@onready var key_hit_sound = $key_hit_sound
@onready var get_fish_sound = $get_fish_sound
@onready var waiting_sound = $waiting_sound
@onready var failure_timer = $failure_timer
@onready var break_sound = $break_sound
@onready var fish_catch = $catch_window/Control/fish_catch

const DOWN_ARROW = preload("res://Scenes/arrow_keys/down_arrow.tscn")
const LEFT_ARROW = preload("res://Scenes/arrow_keys/left_arrow.tscn")
const RIGHT_ARROW = preload("res://Scenes/arrow_keys/right_arrow.tscn")
const UP_ARROW = preload("res://Scenes/arrow_keys/up_arrow.tscn")

var fish_amount: int = 0
var catch_amount: int = 1
var key_amount: int = 2
var wait_count: int = 0
var wait_req: int = 1
var catching: bool = false
var success: bool = false
var key_array: Array[int] = []
var pressed_array: Array[int] = []
var key_list_node: HBoxContainer
var catch_timelimit_min: int = 2
var catch_timelimit_max: int = 10
var time_reducer_rounds: int = 5

func _ready():
	background.play("default")
	engine.play("default")
	left_pole.play("fishing")
	right_pole.play("fishing")
	alert_img.play("waiting")
	catch_amount = 1 + Global.round
	var time_reducer = floori(Global.round/time_reducer_rounds)
	if(time_reducer <= catch_timelimit_min):
		progress_bar.max_value = catch_timelimit_max - time_reducer
		progress_bar.value = progress_bar.max_value
	else:
		progress_bar.max_value = catch_timelimit_min
		progress_bar.value = progress_bar.max_value
	pass

func _input(event):
	if(event.is_action_pressed("skip")):
		succeed_event()
	pass

func _process(delta):
	if(!catching and !success):
		if(wait_count >= wait_req):
			if(wait_req == 1):
				wait_req = 2
			catch_window.visible = false
			trigger_bite()
			progress_bar.value = progress_bar.max_value
			progress_bar.visible = true
			game_timer.start()
			catching = true
	else:
		if(!success):
			check_keypress()

func _on_alert_img_animation_looped():
	if(alert_img.animation == &"waiting"):
		wait_count = wait_count + 1
	pass
	
func trigger_bite():
	alert_img.play("bite_alert")
	left_pole.play("catching")
	right_pole.play("catching")
	catch_sound.play()
	
	#choose fish
	fish_catch.frame = randi() % 15
	#generate key list
	key_amount = 2 + (floori(Global.round/2))
	var random = RandomNumberGenerator.new()
	key_list_node = get_node("key_container")
	random.randomize()
	for i in key_amount:
		var tmp = random.randi_range(1,4)
		key_array.append(tmp)
		match tmp:
			1:
				var left_temp = LEFT_ARROW.instantiate()
				key_list_node.add_child(left_temp)
			2:
				var up_temp = UP_ARROW.instantiate()
				key_list_node.add_child(up_temp)
			3:
				var down_temp = DOWN_ARROW.instantiate()
				key_list_node.add_child(down_temp)
			4:
				var right_temp = RIGHT_ARROW.instantiate()
				key_list_node.add_child(right_temp)
	
func check_keypress():
	if(key_array.is_empty()):
		succeed_event()
	
	if(Input.is_anything_pressed()):
		if(Input.is_action_just_pressed("left")):
			if(key_array[0] == 1):
				if(key_array.size() > 1):
					var tween = create_tween()
					tween.tween_property(key_list_node.get_child(1),"position",key_list_node.get_child(0).position,0.1)
				key_array.pop_front()
				key_list_node.get_child(0).queue_free()
				key_hit_sound.play()
			else:
				fail_event()
				#fail out
			
		if(Input.is_action_just_pressed("up")):
			if(key_array[0] == 2):
				if(key_array.size() > 1):
					var tween = create_tween()
					tween.tween_property(key_list_node.get_child(1),"position",key_list_node.get_child(0).position,0.1)
				key_array.pop_front()
				key_list_node.get_child(0).queue_free()
				key_hit_sound.play()
			else:
				fail_event()
				#fail out
			
		if(Input.is_action_just_pressed("down")):
			if(key_array[0] == 3):
				if(key_array.size() > 1):
					var tween = create_tween()
					tween.tween_property(key_list_node.get_child(1),"position",key_list_node.get_child(0).position,0.1)
				key_array.pop_front()
				key_list_node.get_child(0).queue_free()
				key_hit_sound.play()
			else:
				fail_event()
				#fail out
			
		if(Input.is_action_just_pressed("right")):
			if(key_array[0] == 4):
				if(key_array.size() > 1):
					var tween = create_tween()
					tween.tween_property(key_list_node.get_child(1),"position",key_list_node.get_child(0).position,0.1)
				key_array.pop_front()
				key_list_node.get_child(0).queue_free()
				key_hit_sound.play()
			else:
				fail_event()
				#fail out
			
func fail_event():
	key_container.visible = false
	progress_bar.visible = false
	game_timer.stop()
	break_sound.play()
	alert_img.play("break_sad")
	left_pole.play("snapping")
	right_pole.play("snapping")
	failure_timer.start()

func succeed_event():
	get_fish_sound.play()
	
	var fish = fish_catch.frame
	Global.catch_array.append(fish)
	query_catalogue(fish)
	game_timer.stop()
	progress_bar.visible = false
	catching = false
	fish_amount += 1
	Global.score += 1
	catch_window.visible = true
	left_pole.play("idle")
	right_pole.play("idle")
	alert_img.play("idle")
	
	if(fish_amount >= catch_amount):
		success = true
		success_timer.start()
	else:
		left_pole.play("fishing")
		right_pole.play("fishing")
		wait_count = 0
		alert_img.play("waiting")
	pass

func _on_timer_timeout():
	progress_bar.value -= 1
	if(progress_bar.value == 0):
		game_timer.stop()
		fail_event()
	
func _on_success_timer_timeout():
	SignalBus.progress_scene.emit(2)
	pass # Replace with function body.

func _on_failure_timer_timeout():
	SignalBus.gameover_scene.emit()
	pass # Replace with function body.

func query_catalogue(fish: int):
	if(!Global.catalogue_complete):
		if(!Global.catalogue_array.has(fish)):
			Global.catalogue_array.append(fish)
