extends TabContainer

#Tab Numbers
var TAB_EQUIP = 0
var TAB_WEAPONS = 1
var TAB_ARMOR = 2
var TAB_RINGS = 3

#size and positioning
var slot_size =Vector2(100,100)
var slot_spacing = 5

#equiping states
var WAITING = 0
var EQUIPPING = 1

var rings;
var ringSlots;

var state;
var equipSlot;


func _ready():
	self.set_process(true)
	self.set_pos(Vector2(get_viewport_rect().size.width/2-self.get_rect().size.width/2,get_viewport_rect().size.height/2-self.get_rect().size.height/2))
	
	#load rings
	rings = []
	ringSlots = [-1,-1,-1,-1]
	
	#test rings
	rings.append("Blade ring")
	rings.append("Rock Ring")
	rings.append("Sharp Ring")
	rings.append("Double Blade Ring")
	
	for r in rings:
		_add_ring_to_inventory(r)
	
	
	state = WAITING
	equipSlot = get_node(".")

func _process(delta):
	var num = get_node("Rings/ScrollContainer/RingSlotContainer").get_child_count()
	for i in range(num):
		var btn = get_node("Rings/ScrollContainer/RingSlotContainer").get_child(i)
		if(btn.is_pressed()&&state==EQUIPPING):
			ringSlots[0] = i;
			equipSlot.get_child(0).set_text(btn.get_name())
			self.set_current_tab(TAB_EQUIP)
			state = WAITING
			equipSlot = get_node("")

func _on_RingSlot1_pressed():
	self.set_current_tab(TAB_RINGS)
	state = EQUIPPING
	equipSlot = get_node("Equip/RingSlot1")

func _on_Inventory_tab_changed( tab ):
	state = WAITING
	equipSlot = get_node("")


func _on_RingSlot2_pressed():
	self.set_current_tab(TAB_RINGS)
	state = EQUIPPING
	equipSlot = get_node("Equip/RingSlot2")


func _on_RingSlot3_pressed():
	self.set_current_tab(TAB_RINGS)
	state = EQUIPPING
	equipSlot = get_node("Equip/RingSlot3")


func _on_RingSlot4_pressed():
	self.set_current_tab(TAB_RINGS)
	state = EQUIPPING
	equipSlot = get_node("Equip/RingSlot4")


func _add_ring_to_inventory(name):
	var Slot = Button.new()
	var SlotLabel = Label.new()
	SlotLabel.set_text(name)
	#SlotLabel.set_autowrap(true)
	Slot.add_child(SlotLabel)
	Slot.set_name(name)
	Slot.set_custom_minimum_size(slot_size)
	get_node("Rings/ScrollContainer/RingSlotContainer").add_child(Slot)
	
