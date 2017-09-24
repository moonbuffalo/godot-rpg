
extends RigidBody2D

var speed = 100;

func _ready():
	self.set_process(true)

func _process(delta):
	var moveTo = self.get_pos();
	

		
	if(Input.is_key_pressed(KEY_W)):
		moveTo.y -= 100*delta
	if(Input.is_key_pressed(KEY_S)):
		moveTo.y += 100*delta
	if(Input.is_key_pressed(KEY_D)):
		moveTo.x += 100*delta
	if(Input.is_key_pressed(KEY_A)):
		moveTo.x -= 100*delta
	self.set_pos(moveTo)
	
	if(Input.is_key_pressed(KEY_F)):
		save_game("test")
		
		
		
	if(Input.is_key_pressed(KEY_g)):
		load_game("test")
	self.set_pos(moveTo)


