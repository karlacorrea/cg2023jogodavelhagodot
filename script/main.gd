extends Control

@export var circle_scene : PackedScene
@export var cross_scene : PackedScene
var player : int
var grid_data : Array
var grid_pos : Vector2i
var board_size : int
var cell_size : int
# Called when the node enters the scene tree for the first time.
func _ready():
	board_size =$Board.texture.get_width()
		#divide board size by 3 to get the size of invivudial cell
	cell_size = board_size /3	 
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#check if mouse on the game board
			if event.position.x < board_size:
				#convert mouse position into grid location
				grid_pos = Vector2i(event.position / cell_size)
				if grid_data[grid_pos.y][grid_pos.x] == 0:
					grid_data[grid_pos.y][grid_pos.x] = player
					#place that player's marker
					create_marker(player, grid_pos * cell_size + Vector2i(cell_size / 2, cell_size / 2))
					player *= -1
					print(grid_data)
				
func new_game():
	player = 1
	grid_data = [
		[0, 0, 0],
		[0, 0, 0], 
		[0, 0, 0]
		]

func create_marker(player, position):
	#create a marker node and add it as a child
	if player ==1:
		var circle = circle_scene.instantiate()
		circle.position = position
		add_child(circle)
	else:
		var cross = cross_scene.instantiate()
		cross.position = position
		add_child(cross)	
