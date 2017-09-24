extends Node

var currentScene = null
var default_settings_data = {"volume_music":1.0,"volume_effects":1.0}
var settings_file = File.new()
var save_path_settings = "user://userSettings.bin"
var save_path = "user://saves/"
var save_name = "PlayerSave"
var savegame = File.new() 

func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1)
	check_settings_file()
	read_settings()
	var directory = Directory.new();
	if directory.open("user://")== OK:
		if !directory.dir_exists("saves"):
			directory.make_dir("saves")
	

func setScene(var scene):
	currentScene.queue_free()
	var s = ResourceLoader.load(scene)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)
	
	
func check_settings_file():
	if not settings_file.file_exists(save_path_settings):
		settings_file.open_encrypted_with_pass(save_path_settings, File.WRITE, "cliffside")
		settings_file.store_var(default_settings_data)
		settings_file.close()

func read_settings():
	print("reading")
	settings_file.open_encrypted_with_pass(save_path_settings, File.READ, "cliffside")
	var settings_data = settings_file.get_var()
	settings_file.close()
	Globals.set("VOLUME_EFFECTS",settings_data["volume_effects"])
	Globals.set("VOLUME_MUSIC",settings_data["volume_music"])
	print(settings_data["volume_effects"])

func save_settings():
	print("saving")
	var settings_data = {"volume_music":Globals.get("VOLUME_MUSIC"),"volume_effects":Globals.get("VOLUME_EFFECTS")}
	settings_file.open_encrypted_with_pass(save_path_settings, File.WRITE, "cliffside")
	settings_file.store_var(settings_data)
	settings_file.close()

func save_game(var save_data):
	var save_number = 0
	var full_save_path= str(save_path,save_name,save_number,".save")
	while File.new().file_exists(full_save_path):
		save_number = save_number+1
		full_save_path= str(save_path,save_name,save_number,".save")
	savegame.open(full_save_path, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()

func load_game(var save_path):
	savegame.open(save_path, File.READ) 
	var save_data = savegame.get_var() 
	savegame.close() 
	return save_data


func get_saves():
	var directory = Directory.new()
	var saves = []
	var save_extension = ".save"
	if directory.open(save_path) ==OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name!="":
			if file_name.substr(file_name.length()-save_extension.length(),save_extension.length()) == save_extension:
					saves.append(file_name)
			file_name = directory.get_next()
	return saves

func getCurrentScene():
	return currentScene
