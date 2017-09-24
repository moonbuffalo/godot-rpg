
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	self.set_pos(Vector2(get_viewport_rect().size.width/2-self.get_rect().size.width/2,get_viewport_rect().size.height/2-self.get_rect().size.height/2))
	#Check for saved game, if none, disable continue button

func _on_settings_pressed():
	get_node("/root/global").setScene("res://Settings.scn")


func _on_quit_pressed():
	get_tree().quit()

func resize():
	self.set_pos(Vector2(get_viewport_rect().size.width/2-self.get_rect().size.width/2,get_viewport_rect().size.height/2-self.get_rect().size.height/2))


func _on_Continue_pressed():
	get_node("/root/global").setScene("res://Continue.scn")

