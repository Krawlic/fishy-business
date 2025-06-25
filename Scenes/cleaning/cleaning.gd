extends Node2D

const DOWN_ARROW = preload("res://Scenes/arrow_keys/down_arrow.tscn")
const LEFT_ARROW = preload("res://Scenes/arrow_keys/left_arrow.tscn")
const RIGHT_ARROW = preload("res://Scenes/arrow_keys/right_arrow.tscn")
const UP_ARROW = preload("res://Scenes/arrow_keys/up_arrow.tscn")

@onready var down_arrow = $down_arrow
@onready var right_arrow = $right_arrow
@onready var left_arrow = $left_arrow
@onready var up_arrow = $up_arrow
@onready var wait_timer = $wait_timer
@onready var success_timer = $success_timer
@onready var fail_timer = $fail_timer
@onready var catch_sprite = $cleaning_screen/catch_sprite
@onready var key_hit_sound = $key_hit_sound
@onready var break_sound = $break_sound
@onready var table_slot = $cleaning_screen/objects/table/table_slot
@onready var sink_slot = $cleaning_screen/objects/sink/sink_slot
@onready var cooler_slot = $cleaning_screen/objects/cooler/cooler_slot
@onready var wheelbarrow_slot = $cleaning_screen/objects/wheelbarrow/wheelbarrow_slot
@onready var trashcan_slot = $cleaning_screen/objects/trashcan/trashcan_slot
@onready var trashcan = $cleaning_screen/objects/trashcan
@onready var sink = $cleaning_screen/objects/sink
@onready var trash_sound = $trash_sound
@onready var table_sound = $table_sound
@onready var sink_sound = $sink_sound
@onready var cooler_sound = $cooler_sound
@onready var success_sound = $success_sound
@onready var fishspawn_sound = $fishspawn_sound
@onready var ocean_splash = $cleaning_screen/objects/ocean_slot/ocean_splash
@onready var ocean_slot = $cleaning_screen/objects/ocean_slot
@onready var splash_timer = $cleaning_screen/objects/ocean_slot/ocean_splash/splash_timer

var catch_array: Array[int] = []
var catch_type: String = ""
var cleaning: bool = false
var cleaning_steps: Array[String] = []
var key_list_node: HBoxContainer

func _ready():
	catch_array = Global.catch_array
	sink.play("running")
	wait_timer.start()
	pass
	
func _process(delta):
	if(cleaning):
		if(cleaning_steps.is_empty()):
			Global.score += 1
			reset_for_next_fish()
		else:
			process_catchable()
	pass
	
func _on_wait_timer_timeout():
	if(!catch_array.is_empty()):
		spawn_next_fish()
	else:
		success_event()
	pass

func spawn_next_fish():
	catch_sprite.position = wheelbarrow_slot.position
	catch_sprite.visible = true
	cleaning = true
	fishspawn_sound.play()
	
	var fish = catch_array[0]
	catch_sprite.frame = fish
	
	var steps: Array[String] = []
	# Fish 0-7, Shellfish 8-9, Trash 10-14
	if(fish < 8):
		catch_type = "fish"
		steps = ["up","left","down"]
		load_keylist(steps)
		pass
	elif(fish < 10):
		catch_type = "shellfish"
		steps = ["left","down"]
		load_keylist(steps)
		pass
	else:
		catch_type = "trash"
		steps = ["right"]
		load_keylist(steps)
		pass
		
	cleaning_steps = steps
	pass

func process_catchable():
	if(Input.is_anything_pressed()):
		#Move to Sink
		if(Input.is_action_just_pressed("left")):
			if(cleaning_steps[0] == "left"):
				cleaning_steps.pop_front()
				key_list_node.get_child(0).queue_free()
				key_hit_sound.play()
				move_catch(catch_sprite,sink_slot)
				sink_sound.play()
			else:
				fail_event()
				#fail out
		#Move to Table
		if(Input.is_action_just_pressed("up")):
			if(cleaning_steps[0] == "up"):
				cleaning_steps.pop_front()
				key_list_node.get_child(0).queue_free()
				key_hit_sound.play()
				catch_sprite.frame = 15
				move_catch(catch_sprite,table_slot)
				table_sound.play()
			else:
				fail_event()
				#fail out
		#Move to Cooler	
		if(Input.is_action_just_pressed("down")):
			if(cleaning_steps[0] == "down"):
				cleaning_steps.pop_front()
				key_list_node.get_child(0).queue_free()
				key_hit_sound.play()
				move_catch(catch_sprite,cooler_slot)
				cooler_sound.play()
			else:
				fail_event()
				#fail out
		#Move to Trash	
		if(Input.is_action_just_pressed("right")):
			if(cleaning_steps[0] == "right"):
				cleaning_steps.pop_front()
				key_list_node.get_child(0).queue_free()
				key_hit_sound.play()
				trashcan.play("open")
				move_catch(catch_sprite,trashcan_slot)
				trash_sound.play()
			else:
				fail_event()
				#fail out
	pass
	
func reset_for_next_fish():
	catch_sprite.position = wheelbarrow_slot.position
	cleaning = false
	catch_sprite.visible = false
	catch_array.pop_front()
	wait_timer.start()
	pass

func move_catch(fish: Sprite2D, slot: Node2D):
	var tween = create_tween()
	tween.tween_property(fish,"position",slot.position,.1)

func load_keylist(steps: Array[String]):
	key_list_node = get_node("key_container")
	for step in steps:
		match step:
			"left":
				var left_temp = LEFT_ARROW.instantiate()
				key_list_node.add_child(left_temp)
			"up":
				var up_temp = UP_ARROW.instantiate()
				key_list_node.add_child(up_temp)
			"down":
				var down_temp = DOWN_ARROW.instantiate()
				key_list_node.add_child(down_temp)
			"right":
				var right_temp = RIGHT_ARROW.instantiate()
				key_list_node.add_child(right_temp)
	pass
	
func success_event():
	success_sound.play()
	success_timer.start()
	pass

func fail_event():
	key_list_node.visible = false
	splash_timer.start()
	move_catch(catch_sprite,ocean_slot)
	cleaning = false
	break_sound.play()
	fail_timer.start()
	pass

func _on_fail_timer_timeout():
	SignalBus.gameover_scene.emit()
	pass 

func _on_success_timer_timeout():
	SignalBus.progress_scene.emit(4)
	pass # Replace with function body.

func _on_splash_timer_timeout():
	catch_sprite.visible = false
	ocean_splash.play("splash")
	pass # Replace with function body.
