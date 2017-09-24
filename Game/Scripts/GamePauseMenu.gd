
extends PopupMenu


func _ready():
	self.set_process(true)
	#self.set_pos(Vector2(get_viewport_rect().size.width/2-self.get_rect().size.width/2,get_viewport_rect().size.height/2-self.get_rect().size.height/2))

func _process(delta):
	pass
	#self.set_pos(Vector2(get_viewport_rect().size.width/2-self.get_rect().size.width/2,get_viewport_rect().size.height/2-self.get_rect().size.height/2))




func _on_resume_pressed():
	get_tree().set_pause(false)
	self.hide()


func _on_settings_pressed():
	get_node("NormalPause").hide()
	get_node("SettingsPause").show()


func _on_Back_pressed():
	get_node("NormalPause").show()
	get_node("SettingsPause").hide()


func _on_quit_pressed():
	get_node("/root/global").setScene("res://MainMenu.scn")
	get_tree().set_pause(false)

func resize():
	pass
	#self.set_pos(Vector2(get_viewport_rect().size.width/2-self.get_rect().size.width/2,get_viewport_rect().size.height/2-self.get_rect().size.height/2))

