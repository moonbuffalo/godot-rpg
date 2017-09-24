
extends RichTextLabel

# member variables here, example:
# var a=2
# var b="textvar"

var count = 0;

func _ready():
	self.add_text("Hello World");




func _on_Timer_2_timeout():
	count+=1
	self.clear()
	self.add_text(str("Hello world! Seconds elapsed:", count))
