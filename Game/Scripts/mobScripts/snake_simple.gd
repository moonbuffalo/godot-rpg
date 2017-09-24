
extends Node2D

var NOTHING = 0
var PATHING = 1
var STALKING = 2
var ATTACKING = 3
var state = NOTHING;



var ATTACK_ATTACKING = 0
var ATTACK_COOLDOWN = 1
var attack_state = ATTACK_ATTACKING;


var DEBUG = false


var target_path = Vector2Array()
var velocity = Vector2()
var speed =95


var motion = Vector2()



#attack stuff
var attack_duration = .50
var cooldown_duration = 1.0
var attack_timer = 0.0
var cooldown_timer = 0.0
var attack_speed = 200

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	target_path = get_parent().get_node("Enemies").get_simple_path(get_pos(), get_parent().get_parent().get_node("Player").get_pos())
	
	var distance_to_player =get_pos().distance_to(get_parent().get_parent().get_node("Player").get_pos())
	
	if(distance_to_player>200):
		state = NOTHING
	elif(target_path.size()>2||distance_to_player>100):
		state = PATHING
	elif(distance_to_player>70):
		state = STALKING
	else:
		state = ATTACKING
	
	get_node("Sprite").set_rot( get_pos().angle_to_point( target_path[1] ) )
	
	
	if(state==NOTHING):
		velocity = Vector2(0,0)
	if(state==PATHING):
		chase_player();
	elif(state ==STALKING):
		chase_player();
		#slow down
		velocity = velocity*.3
	elif(state ==ATTACKING):
		attack(delta);
		

	push_from_enemies()
	velocity*=delta
	set_pos(Vector2(get_pos().x+velocity.x,get_pos().y+velocity.y))
	
	update()

func chase_player():
	velocity.x  = target_path[1].x-get_pos().x
	velocity.y = target_path[1].y-get_pos().y
	
	var len = sqrt(velocity.x*velocity.x+velocity.y*velocity.y)
	if(len!=0):
		velocity.x/=len
		velocity.y/=len
	else:
		velocity.x=0
		velocity.y=0
	
	velocity.x *=speed
	velocity.y *=speed

func attack(var delta):
	if(attack_state == ATTACK_ATTACKING):
		attack_timer+=delta
		velocity.x  = get_parent().get_parent().get_node("Player").get_pos().x-get_pos().x
		velocity.y = get_parent().get_parent().get_node("Player").get_pos().y-get_pos().y
		velocity = velocity.normalized()*attack_speed
		if(attack_timer>attack_duration):
			attack_timer = 0
			attack_state = ATTACK_COOLDOWN
	elif(attack_state == ATTACK_COOLDOWN):
		cooldown_timer+=delta
		chase_player();
		#slow down
		velocity = velocity*.7
		if(cooldown_timer>cooldown_duration):
			cooldown_timer =0
			attack_state = ATTACK_ATTACKING


func push_from_enemies():
	var enemies = get_parent().get_list_enemies()
	for i in range(0,enemies.size()):
		var distance_to_enemy =get_pos().distance_to(enemies[i].get_pos())
		if(distance_to_enemy<enemies[i].get_soft_radius()+get_soft_radius()&&distance_to_enemy!=0):
			velocity.x += 1/(enemies[i].get_pos().x-get_pos().x)
			velocity.y += 1/(enemies[i].get_pos().y-get_pos().y)
			

func _draw():
	if(target_path.size()&&DEBUG):
		for i in range(0,target_path.size()):
			draw_circle(Vector2(target_path[i].x-get_pos().x,target_path[i].y-get_pos().y),2,Color(1,0,0))
			if(i>0):
				draw_line(Vector2(target_path[i-1].x-get_pos().x,target_path[i-1].y-get_pos().y),Vector2(target_path[i].x-get_pos().x,target_path[i].y-get_pos().y),Color(1,0,0),1.0)

func get_soft_radius():
	return 16
