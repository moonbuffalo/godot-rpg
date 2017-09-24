
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	#place the weapon hud in the bottom left
	get_node("WeaponHud").set_pos(Vector2(0,get_node("WeaponHud").get_viewport_rect().size.height-get_node("WeaponHud").get_rect().size.height))
	get_node("WeaponHud").set_size(Vector2(161.8, 100))
	get_node("WeaponHud").show()
	#place the healthbar at the top right
	get_node("HealthBar").set_pos(Vector2(0,0))
	get_node("HealthBar").set_size(Vector2(400, 25))
	get_node("HealthBar").show()
	#place the stamina bar below the healthbar
	get_node("StaminaBar").set_pos(Vector2(0,get_node("HealthBar").get_rect().size.height))
	get_node("StaminaBar").set_size(Vector2(400, 25))
	get_node("StaminaBar").show()
	#place the mana bar belowthe stamina bar
	get_node("ManaBar").set_pos(Vector2(0,get_node("HealthBar").get_rect().size.height+get_node("StaminaBar").get_rect().size.height))
	get_node("ManaBar").set_size(Vector2(400, 25))
	get_node("ManaBar").show()
	set_process(true)

func _process(delta):
	pass

#create functions to interact with the health bar
func decrease_health(var amount):
	get_node("HealthBar").set_value(get_node("HealthBar").get_value()-amount)
func increase_health(var amount):
	get_node("HealthBar").set_value(get_node("HealthBar").get_value()+amount)
func get_health():
	return get_node("HealthBar").get_value()
func set_health(var amount):
	get_node("HealthBar").set_value(amount)
func set_health_max(var amount):
	get_node("HealthBar").set_max(amount)
func get_health_max(var amount):
	return get_node("HealthBar").get_max()

#create functions to interact with stamina bars
func decrease_stamina(var amount):
	if(get_node("StaminaBar").get_value()-amount>0):
		get_node("StaminaBar").set_value(get_node("StaminaBar").get_value()-amount)
	else:
		get_node("StaminaBar").set_value(0)
func increase_stamina(var amount):
	if(get_node("StaminaBar").get_value()+amount<get_stamina_max()):
		get_node("StaminaBar").set_value(get_node("StaminaBar").get_value()+amount)
	else:
		get_node("StaminaBar").set_value(get_stamina_max())
func get_stamina():
	return get_node("StaminaBar").get_value()
func set_stamina(var amount):
	get_node("StaminaBar").set_value(amount)
func get_stamina_max():
	return get_node("StaminaBar").get_max()
func set_stamina_max(var amount):
	get_node("StaminaBar").set_max(amount)


#create functions to interact with mana bars
func decrease_mana(var amount):
	get_node("ManaBar").set_value(get_node("ManaBar").get_value()-amount)
func increase_mana(var amount):
	get_node("ManaBar").set_value(get_node("ManaBar").get_value()+amount)
func get_mana():
	return get_node("ManaBar").get_value()
func set_mana(var amount):
	get_node("ManaBar").set_value(amount)
func set_mana_max(var amount):
	get_node("ManaBar").set_max(amount)
func get_mana_max():
	return get_node("ManaBar").get_max()