
extends KinematicBody2D


var velocity = Vector2()
var speed = 2.0;
var farDistance  = 70;
var shortDistance = 50;


func _ready():
	self.set_fixed_process(true)
	get_parent().get_parent().add_child(self)

func _fixed_process(delta):
	stepToPlayer()
	
	var motion = velocity
	
	move(motion)
	
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)


func stepToPlayer():
	
	var playerX = get_parent().get_node("Player").get_pos().x
	var differenceX = playerX-get_pos().x
	
	
	var playerY = get_parent().get_node("Player").get_pos().y
	var differenceY = playerY-get_pos().y
	
	var sos = differenceX*differenceX+differenceY*differenceY
	var distance = sqrt(sos)
	
	differenceX/=distance
	differenceY/=distance
	
	velocity.x = differenceX*speed
	velocity.y = differenceY*speed



