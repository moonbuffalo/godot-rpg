var saves = []



func _ready():
	var save_list_node = get_node("save_list_container/save_list")
	
	var button = Button.new()
	button.set_custom_minimum_size(Vector2(0,50))
	button.set_text("New Game")
	button.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	save_list_node.add_child(button);
	button.connect("pressed",self,"_start_new_game");

	saves = get_node("/root/global").get_saves();
	for s in saves:
		var data = get_node("/root/global").load_game("user://saves/"+s)
		var button = Button.new()
		button.set_custom_minimum_size(Vector2(0,50))
		var name = str(data["NAME"])
		button.set_text(name)
		button.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		save_list_node.add_child(button);
		button.connect("pressed",self,"_load_game",[data]);

func _on_btn_start_pressed():
	var save_data = get_node("/root/global").load_game("user://savegame.save");
	Globals.set("SAVEDATA",save_data)
	get_node("/root/global").setScene("res://Game.scn")

func _start_new_game():
	get_node("/root/global").setScene("res://NewGame.scn")

func _on_btn_cancel_pressed():
	get_node("/root/global").setScene("res://MainMenu.scn")

func _load_game(data):
	Globals.set("SAVEDATA",data)
	get_node("/root/global").setScene("res://Game.scn")
