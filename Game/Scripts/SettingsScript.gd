
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	var volumeEffects = Globals.get("VOLUME_EFFECTS")
	var volumeMusic = Globals.get("VOLUME_MUSIC")
	self.get_node("slider_volumeEffects").set_val(volumeEffects*100)
	self.get_node("slider_volumeMusic").set_val(volumeMusic*100)
	self.set_pos(Vector2(get_viewport_rect().size.width/2-self.get_rect().size.width/2,get_viewport_rect().size.height/2-self.get_rect().size.height/2))


func _on_main_menu_pressed():
	get_node("/root/global").save_settings()
	get_node("/root/global").setScene("res://MainMenu.scn")
	


func _on_slider_volumeEffects_value_changed( value ):
	Globals.set("VOLUME_EFFECTS",value/100.0)


func _on_slider_volumeMusic_value_changed( value ):
	Globals.set("VOLUME_MUSIC",value/100.0)

func resize():
	self.set_pos(Vector2(get_viewport_rect().size.width/2-self.get_rect().size.width/2,get_viewport_rect().size.height/2-self.get_rect().size.height/2))
