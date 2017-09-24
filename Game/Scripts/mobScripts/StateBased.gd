
extends Node2D

var NOTHING = 0;
var PATHING = 1;
var WAITING = 2;
var ATTACKING = 3;


var state = PATHING;
var target = Vector2Array()
var velocity = Vector2()
var speed =90




func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	target = get_parent().get_node("Enemies").get_simple_path(get_pos(), get_parent().get_parent().get_node("Player").get_pos())
	
	if(target.size()>2 || get_pos().distance_to(get_parent().get_parent().get_node("Player").get_pos())>50):
		state = PATHING
	else:
		state = WAITING;
	
	
	
	if(state ==PATHING):
		get_node("Sprite").set_rot( get_pos().angle_to_point( target[1] ) )
		chase_player();
	else:
		velocity = Vector2(0,0)
	velocity*=delta
	move(velocity)
	#set_pos(Vector2(get_pos().x+velocity.x,get_pos().y+velocity.y))
	update()

func chase_player():
	velocity.x  = target[1].x-get_pos().x
	velocity.y = target[1].y-get_pos().y
	
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
	if(target.size()&&false):
		for i in range(0,target.size()):
			draw_circle(Vector2(target[i].x-get_pos().x,target[i].y-get_pos().y),2,Color(1,0,0))
			if(i>0):
				draw_line(Vector2(target[i-1].x-get_pos().x,target[i-1].y-get_pos().y),Vector2(target[i].x-get_pos().x,target[i].y-get_pos().y),Color(1,0,0),1.0)

