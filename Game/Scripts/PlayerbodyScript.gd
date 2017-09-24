extends KinematicBody2D

var WALK_SPEED = 100;
var RUN_SPEED = 600;
var speed = WALK_SPEED;



var stamina_regen_rate = 28
var stamina_cost_run = 30
var velocity = Vector2()

#base attributes
var base_maxHealth = 100
var base_attack = 10
var base_defense = 10

#current ingame stats
var health = 100
var maxHealth = 100
var attack = 10
var defense = 10

#stat modifiers & regen
var health_regen = 0
var maxHealth_modifier = 0
var attack_modifier = 0
var defense_modifier = 0


func _fixed_process(delta):
	#look at mouse
	var realMouse = Vector2(get_viewport().get_mouse_pos().x+get_parent().get_screen_position().x,get_viewport().get_mouse_pos().y+get_parent().get_screen_position().y)
	set_rot( get_pos().angle_to_point( realMouse ) + deg2rad(180) )
	
	
	#Check movement keys
	if (Input.is_key_pressed(KEY_A)):
		velocity.x = -1
	elif (Input.is_key_pressed(KEY_D)):
		velocity.x =  1
	else:
		velocity.x = 0
	if (Input.is_key_pressed(KEY_W)):
		velocity.y = -1
	elif (Input.is_key_pressed(KEY_S)):
		velocity.y =  1
	else:
		velocity.y = 0
	
	#normalize speed so player cant go too fast
	var motion = velocity.normalized()*speed * delta
	move(motion)
	
	#If shift is pressed and player has enough stamina, sprint
	if (Input.is_key_pressed(KEY_SHIFT)):
		if(get_parent().get_node("HUD").get_stamina()>0):
			speed = RUN_SPEED
			get_parent().get_node("HUD").decrease_stamina(stamina_cost_run*delta)
		else:
			speed = WALK_SPEED
	else:
		speed = WALK_SPEED
		get_parent().get_node("HUD").increase_stamina(stamina_regen_rate*delta)
	
	#slide the player along whiles they are currently colliding with
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
	
	#keep health updated
	maxHealth = base_maxHealth+maxHealth_modifier
	if(health<maxHealth):
		health+=health_regen
	if(health>maxHealth):
		health = maxHealth
	get_parent().get_node("HUD").set_health(health)
	get_parent().get_node("HUD").set_health_max(maxHealth)
	
	#keep attack & defenseupdated
	attack = base_attack+attack_modifier
	defense = base_defense+defense_modifier


func _ready():
    set_fixed_process(true)

func spawn(var position):
	self.set_pos(position)



func _on_Area2D_area_enter( area ):
	pass#print("Area Entered")


func _on_Area2D_body_enter( body ):
	pass#print("Body Entered")


func _on_Area2D_body_enter_shape( body_id, body, body_shape, area_shape ):
	pass#print("body entered shape")
