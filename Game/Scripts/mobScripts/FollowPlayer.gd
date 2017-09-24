
extends Node2D

var NOTHING = 0
var PATHING = 1
var STALKING = 2
var ATTACKING = 3

var ATTACK_ATTACKING = 0
var ATTACK_COOLDOWN = 1
var attack_state = ATTACK_ATTACKING;


var DEBUG = false

var state = NOTHING
var target_path = Vector2Array()
var velocity = Vector2()
var speed =50
var chaseDistance = 60


var motion = Vector2()


func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	target_path = get_parent().get_parent().get_node("NPCNavigation").get_simple_path(get_pos(), get_parent().get_parent().get_parent().get_node("Player").get_pos())
	
	var distance_to_player =get_pos().distance_to(get_parent().get_parent().get_parent().get_node("Player").get_pos())
	
	if(distance_to_player>700):
		state = NOTHING
	elif(target_path.size()>2||distance_to_player>chaseDistance):
		state = PATHING
	else:
		state = ATTACKING
	
	get_node("Sprite").set_rot( get_pos().angle_to_point( target_path[1] ) )
	
	
	if(state==NOTHING):
		velocity = Vector2(0,0)
	if(state==PATHING):
		chase_player();
		#slow down
		velocity = velocity*.3
	elif(state ==ATTACKING):
		pass
		
	velocity*=delta
	
	var motion = velocity.normalized()*speed * delta
	move(motion)
	
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
		
		
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

func _draw():
	if(target_path.size()&&DEBUG):
		for i in range(0,target_path.size()):
			draw_circle(Vector2(target_path[i].x-get_pos().x,target_path[i].y-get_pos().y),2,Color(1,0,0))
			if(i>0):
				draw_line(Vector2(target_path[i-1].x-get_pos().x,target_path[i-1].y-get_pos().y),Vector2(target_path[i].x-get_pos().x,target_path[i].y-get_pos().y),Color(1,0,0),1.0)

func get_soft_radius():
	return 16
