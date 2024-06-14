extends Control
const ANIMATION_DURATION = 0.5
const ANIMATION_DELAY = 0.1
@onready var option_button = $OptionButton

#var InputResponse = preload("res://scenes/input_response.tscn")
var InputResponseCols = preload("res://scenes/input_response_cols.tscn")
#@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/HistoryRows
@onready var history = $Background/MarginContainer/Rows/GameInfo/MarginContainer/HBoxContainer
#@onready var display = $Dispaly

var sprites = []
var arr : Array 
# Called when the node enters the scene tree for the first time.
func _ready():
	arr = []
	sprites = []
	#populate_arrays()
	
	drop_menu()
	print("array count before sorting:", arr)
	bubble_sort()
	print("Sprites count after sorting:", sprites.size())
	print("array count after sorting:", arr)
	

func drop_menu():
	option_button.add_item("Bubble Sort")
	option_button.add_item("Insertion Sort")
	option_button.add_item("Selection Sort")	
	

func bubble_sort():

	
	for i in range(arr.size() - 1 ):
		# Inner loop for comparing adjacent elements
		print("here")
		for j in range(arr.size() - 1 - i):
			if arr[j] > arr[j + 1]:
				# Swap values in the array manually
				var temp = arr[j]
				arr[j] = arr[j + 1]
				arr[j + 1] = temp
				print(arr)
				

				# Animate swapping nodes
				await animate_swap(j, j + 1)
				var delay_timer = create_delay_timer(ANIMATION_DURATION + ANIMATION_DELAY)
				await delay_timer.timeout
				
				
				#print("here")
				# Create a timer and wait until it times out
				#var timer = get_tree().create_timer(ANIMATION_DURATION + ANIMATION_DELAY)
				
				#await timer.timeout	
				
func create_delay_timer(duration: float):
	var timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.start()
	return timer
func animate_swap(index1 , index2):
	
	var sprite1 = sprites[index1].get_node("Sprite2D")
	var sprite2 = sprites[index2].get_node("Sprite2D")
	
	var original_position1 = sprite1.position
	var original_position2 = sprite2.position
	var tween1 = create_tween()
	
	# Initial position of sprite1
	var initial_position1 = sprite1.position
	
	# Move up a little bit and then right to sprite2's position
	var up_position1 = initial_position1 + Vector2(0, -50)
	var move_to_x1 = sprite2.position.x
	tween1.tween_property(sprite1, "position", up_position1, ANIMATION_DURATION / 3)
	tween1.tween_property(sprite1, "position:x", move_to_x1, ANIMATION_DURATION / 3)
	var move_down_x = original_position2.y
	tween1.tween_property(sprite1, "position:y", move_down_x, ANIMATION_DURATION / 3)
	#await wait_for_tween(tween1)
	# Tween for sprite2
	var tween2 = create_tween()
	
	# Initial position of sprite2
	var initial_position2 = sprite2.position
	
	# Move down a little bit and then left to sprite1's original position
	var down_position2 = initial_position2 + Vector2(0, 50)
	var move_to_x2 = sprite1.position.x
	tween2.tween_property(sprite2, "position", down_position2, ANIMATION_DURATION / 3)
	tween2.tween_property(sprite2, "position:x", move_to_x2, ANIMATION_DURATION / 3)
	var move_up_y = original_position1.y
	tween2.tween_property(sprite2, "position:y", move_up_y, ANIMATION_DURATION / 3)
	#await wait_for_tween(tween2)
	var temp = sprites[index1]
	sprites[index1] = sprites[index2]
	sprites[index2] = temp


	
	
func populate_arrays():
	arr = [5, 3, 8, 1, 2]  # Example values
	for value in arr:
		var input_response = InputResponseCols.instantiate()
		input_response.get_node("Sprite2D/d").text = str(value)
		sprites.append(input_response)
		history.add_child(input_response)


func _on_line_edit_text_submitted(new_text):
	for i in range(new_text.length()):
		if new_text[i] !=' ':
			var int_value = int(new_text[i])
			arr.append(int_value)
			sprites.append(InputResponseCols)
			
	for i in range(arr.size()):
		print(arr[i])
		var input_response = InputResponseCols.instantiate()
		input_response.get_node("Sprite2D/d").text = str(arr[i])
		sprites.append(input_response)
		history.add_child(input_response)
		print("Sprites count:", sprites.size())
		
