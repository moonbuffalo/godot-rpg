
extends StaticBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass




func _on_CliffsideDoor_body_enter( body ):
	get_parent().load_level("res://levels/Cliffside.scn","PlayerSpawn_DungeonArena")
