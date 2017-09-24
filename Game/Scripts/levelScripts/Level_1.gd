
extends StaticBody2D
var enemies = []

func _ready():
	var children = get_node("NPCs").get_children()
	
	while children.size()>0:
		enemies.append(children.pop_back())
	#enemies.append(get_node("Enemy_Snake"))
	#enemies.append(get_node("Enemy_Snake1"))
	#enemies.append(get_node("Enemy_Snake2"))
	#enemies.append(get_node("Enemy_Snake3"))
	pass

func get_list_enemies():
	return enemies

