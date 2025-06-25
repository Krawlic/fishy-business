extends Node2D

@onready var back_btn_page = $Pages/back_btn_page
@onready var select_sound = $select_sound
@onready var back_btn = $GridContainer/back_btn

var page_node: Node2D

func _ready():
	back_btn.grab_focus()

func _on_back_btn_button_down():
	select_sound.play()
	pass # Replace with function body.
	
func _on_back_btn_button_up():
	SignalBus.progress_scene.emit(7)
	pass # Replace with function body.

func _on_back_btn_page_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_back_btn_page_button_up():
	back_btn.grab_focus()
	page_node.visible = false
	back_btn_page.visible = false
	pass # Replace with function body.

func _on_sardine_button_down():
	select_sound.play()
	pass # Replace with function body.

func _on_sardine_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Sardine").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.

func _on_lionfish_button_down():
	select_sound.play()
	pass # Replace with function body.

func _on_lionfish_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Lionfish").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.

func _on_shrimp_button_down():
	select_sound.play()
	pass # Replace with function body.

func _on_shrimp_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Shrimp").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.

func _on_squid_button_down():
	select_sound.play()
	pass # Replace with function body.

func _on_squid_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Squid").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_tuna_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_tuna_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Tuna").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_shark_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_shark_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Shark").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_seahorse_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_seahorse_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Seahorse").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_mahimahi_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_mahimahi_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Mahi").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_starfish_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_starfish_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Star").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_scallop_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_scallop_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Scallop").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_skeleton_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_skeleton_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Bones").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_boot_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_boot_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Boot").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_seaweed_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_seaweed_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Seaweed").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_anchor_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_anchor_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Anchor").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.


func _on_can_button_down():
	select_sound.play()
	pass # Replace with function body.


func _on_can_button_up():
	back_btn_page.grab_focus()
	page_node = get_node("Pages/Soda").get_child(0)
	page_node.visible = true
	back_btn_page.visible = true
	pass # Replace with function body.
