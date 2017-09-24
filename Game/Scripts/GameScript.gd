extends Node

var isInventoryOpen
var Previous_E
var levelNode
#save specific variables
var name = ""
var level = ""
var spawn = ""
var save_data = {"Level": level, "Name":name,"Level":"","PlayerSpawn":spawn} 



func _ready():
	self.set_process(true)
	isInventoryOpen = false
	Previous_E = false
	#
	get_node("HUD").set_health_max(300)
	get_node("HUD").set_health(150)
	get_node("HUD").set_stamina_max(300)
	get_node("HUD").set_stamina(150)
	get_node("HUD").set_mana_max(300)
	get_node("HUD").set_mana(150)
	#load information from the global values
	save_data = Globals.get("SAVEDATA")
	level = save_data["LEVEL"]
	spawn = save_data["PLAYERSPAWN"]
	name = save_data["NAME"]
	load_level("res://levels/"+level,spawn)
	get_node("Player/Camera2D").make_current()


func _process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().set_pause(true)
		get_node("HUD/Pause").show();
	if(Input.is_key_pressed(KEY_2)):
		load_level("res://levels/Level_Cliff_1.scn","PlayerSpawn")
	if(Input.is_key_pressed(KEY_1)):
		load_level("res://levels/Level_Cliff_1.scn","PlayerSpawn_DungeonArena")
	if(Input.is_key_pressed(KEY_E)):
		if(isInventoryOpen&&!Previous_E):
			get_node("HUD/Inventory").hide()
			isInventoryOpen = false
		elif(!Previous_E):
			get_node("HUD/Inventory").show()
			isInventoryOpen = true
		Previous_E = true;
	else:
		Previous_E = false

func load_level(var level, var spawn):
	remove_child(levelNode)
	var scene = load(level)
	levelNode = scene.instance()
	add_child(levelNode)
	self.move_child(levelNode,0)
	get_node("Player").spawn(levelNode.get_node(spawn).get_pos())


func get_screen_position():
	var camPos = get_node("Player/Camera2D").get_camera_screen_center()
	var screenPos = Vector2(camPos.x-get_viewport().get_rect().size.width/2,camPos.y-get_viewport().get_rect().size.height/2)
	return screenPos

func save_game():
	save_data["LEVEL"] = level
	save_data["PLAYERSPAWN"] = "PlayerSpawn"
	save_data["NAME"] = name
	get_node("/root/global").save_game(save_data)

func setPlayerPos(var position):
	get_node("Player").set_pos(position)



func _on_btn_save_pressed():
	save_game()


func _on_Area2D_area_enter_shape( area_id, area, area_shape, area_shape ):
	pass
	#print("Area entered shape")
