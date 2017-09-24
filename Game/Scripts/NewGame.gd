
func _ready():
	get_node("option_class").add_item("Warrior")
	get_node("option_class").add_item("Archer")
	get_node("option_class").add_item("Mage")

func _on_main_menu_pressed():
	get_node("/root/global").setScene("res://MainMenu.scn")


func _on_start_pressed():
	var save_data = {"LEVEL": "cave1.scn", "NAME":get_node("txt_name").get_text(),"PLAYERSPAWN":"PlayerSpawn"} 
	Globals.set("SAVEDATA",save_data)
	get_node("/root/global").setScene("res://Game.scn")
