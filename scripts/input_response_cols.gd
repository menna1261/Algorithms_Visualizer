extends HBoxContainer
@onready var sprite_2d = $Sprite2D
#@onready var d = $d

func set_text(input : String):
	#var string_value = str(input)
	$Sprite2D/d.text = input
	
