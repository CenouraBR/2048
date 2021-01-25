extends Control

export(int) var height = 4
export(int) var width = 4
export(int) var initial_pieces = 2
export(int) var pieces_turn = 1
export(int) var margin = 10
export(int) var piece_width = 50
export(int) var piece_height = 50

const Piece = preload("res://Scene/Piece.tscn")

var board = []

func _ready():
	randomize()
	setup_board()
	init_board()
	
func move():
	if Input.is_action_just_pressed("ui_left"):
		var i=0
		while(i<=width):
			for x in range(0, width-1):
				for y in range(0, height):
					if is_free(x, y):
						board[x][y] = board[x+1][y]
						board[x+1][y] = null
			i +=1
	
		for x in range(0, width):
			for y in range(0, height):
				if not is_free(x,y):
					if x == 0:
						continue
					else: 
						if board[x-1][y] == null:
							continue
						if board[x][y].value1 == board[x-1][y].value1:
							if board[x-1][y].value1*2 == 4:
								board[x-1][y].color = Color(0.90,0.85,0.76)
							if board[x-1][y].value1*2 == 8:
								board[x-1][y].color = Color(0.94,0.69,0.47)
							if board[x-1][y].value1*2 == 16:
								board[x-1][y].color = Color(0.94,0.53,0.32)
							if board[x-1][y].value1*2 == 32:
								board[x-1][y].color = Color(0.96,0.47,0.36)
							if board[x-1][y].value1*2 == 64:
								board[x-1][y].color = Color(0.97,0.35,0.25)
							if board[x-1][y].value1*2 == 128:
								board[x-1][y].color = Color(0.92,0.81,0.43)
							if board[x-1][y].value1*2 == 256:
								board[x-1][y].color = Color(0.90,0.77,0.34)
							if board[x-1][y].value1*2 == 512:
								board[x-1][y].color = Color(0.92,0.75,0.26)
							if board[x-1][y].value1*2 == 1024:
								board[x-1][y].color = Color(0.94,0.74,0.14)
							if board[x-1][y].value1*2 == 2048:
								board[x-1][y].color = Color(0.96,0.75,0.03)
							if board[x-1][y].value1*2 >= 4096:
								board[x-1][y].color = Color(0.19,0.19,0.19)
							GameEvent.emit_signal("points_gained", board[x-1][y].value1*2)
							board[x-1][y].set_value(board[x-1][y].value1*2)
							board[x][y].free()
						else:
							continue

		for y in range(0, width):
			for x in range(0, height):
				if not is_free(x,y):
					board[x][y].rect_position = get_pos_from_grid_pos(x, y)
		new_turn()

	if Input.is_action_just_pressed("ui_right"):
		var k = 0
		while(k<width):
			var i = width-1
			var j = height-1
			while(i>0):
				j=height-1
				while(j>=0):
					if is_free(i, j):
						board[i][j] = board[i-1][j]
						board[i-1][j] = null
					j-=1
				i-=1
			k+=1
			
		var i = width-1
		var j = height-1
		while(i>=0):
			j=height-1
			while(j>=0):
				if not is_free(i,j):
					if i == width-1:
						j-=1
						continue
					else: 
						if board[i+1][j] == null:
							j-=1
							continue
						if board[i][j].value1 == board[i+1][j].value1:
							if board[i+1][j].value1*2 == 4:
								board[i+1][j].color = Color(0.90,0.85,0.76)
							if board[i+1][j].value1*2 == 8:
								board[i+1][j].color = Color(0.94,0.69,0.47)
							if board[i+1][j].value1*2 == 16:
								board[i+1][j].color = Color(0.94,0.53,0.32)
							if board[i+1][j].value1*2 == 32:
								board[i+1][j].color = Color(0.96,0.47,0.36)
							if board[i+1][j].value1*2 == 64:
								board[i+1][j].color = Color(0.97,0.35,0.25)
							if board[i+1][j].value1*2 == 128:
								board[i+1][j].color = Color(0.92,0.81,0.43)
							if board[i+1][j].value1*2 == 256:
								board[i+1][j].color = Color(0.90,0.77,0.34)
							if board[i+1][j].value1*2 == 512:
								board[i+1][j].color = Color(0.92,0.75,0.26)
							if board[i+1][j].value1*2 == 1024:
								board[i+1][j].color = Color(0.94,0.74,0.14)
							if board[i+1][j].value1*2 == 2048:
								board[i+1][j].color = Color(0.96,0.75,0.03)
							if board[i+1][j].value1*2 >= 4096:
								board[i+1][j].color = Color(0.19,0.19,0.19)
							GameEvent.emit_signal("points_gained", board[i+1][j].value1*2)
							board[i+1][j].set_value(board[i+1][j].value1*2)
							board[i][j].free()
						else:
							j-=1
							continue
				j-=1
			i-=1
		
		for y in range(0, width):
			for x in range(0, height):
				if not is_free(x,y):
					board[x][y].rect_position = get_pos_from_grid_pos(x, y)
		new_turn()

	if Input.is_action_just_pressed("ui_up"):
		var i=0
		while(i<height):
			for x in range(0, width):
				for y in range(0, height-1):
					if is_free(x, y):
						board[x][y] = board[x][y+1]
						board[x][y+1] = null
			i +=1
		
		for x in range(0, width):
			for y in range(0, height):
				if not is_free(x,y):
					if y == 0:
						continue
					else: 
						if board[x][y-1] == null:
							continue
						if board[x][y].value1 == board[x][y-1].value1:
							if board[x][y-1].value1*2 == 4:
								board[x][y-1].color = Color(0.90,0.85,0.76)
							if board[x][y-1].value1*2 == 8:
								board[x][y-1].color = Color(0.94,0.69,0.47)
							if board[x][y-1].value1*2 == 16:
								board[x][y-1].color = Color(0.94,0.53,0.32)
							if board[x][y-1].value1*2 == 32:
								board[x][y-1].color = Color(0.96,0.47,0.36)
							if board[x][y-1].value1*2 == 64:
								board[x][y-1].color = Color(0.97,0.35,0.25)
							if board[x][y-1].value1*2 == 128:
								board[x][y-1].color = Color(0.92,0.81,0.43)
							if board[x][y-1].value1*2 == 256:
								board[x][y-1].color = Color(0.90,0.77,0.34)
							if board[x][y-1].value1*2 == 512:
								board[x][y-1].color = Color(0.92,0.75,0.26)
							if board[x][y-1].value1*2 == 1024:
								board[x][y-1].color = Color(0.94,0.74,0.14)
							if board[x][y-1].value1*2 == 2048:
								board[x][y-1].color = Color(0.96,0.75,0.03)
							if board[x][y-1].value1*2 >= 4096:
								board[x][y-1].color = Color(0.19,0.19,0.19)
							GameEvent.emit_signal("points_gained", board[x][y-1].value1*2)
							board[x][y-1].set_value(board[x][y-1].value1*2)
							board[x][y].free()
						else:
							continue
		
		for y in range(0, width):
			for x in range(0, height):
				if not is_free(x,y):
					board[x][y].rect_position = get_pos_from_grid_pos(x, y)
		new_turn()

	if Input.is_action_just_pressed("ui_down"):
		var k = 0
		while(k<height):
			var i = width-1
			var j = height-1
			while(i>=0):
				j=height-1
				while(j>0):
					if is_free(i, j):
						board[i][j] = board[i][j-1]
						board[i][j-1] = null
					j-=1
				i-=1
			k+=1
			
		var i = width-1
		var j = height-1
		while(i>=0):
			j=height-1
			while(j>=0):
				if not is_free(i,j):
					if j == height-1:
						j-=1
						continue
					else: 
						if board[i][j+1] == null:
							j-=1
							continue
						if board[i][j].value1 == board[i][j+1].value1:
							if board[i][j+1].value1*2 == 4:
								board[i][j+1].color = Color(0.90,0.85,0.76)
							if board[i][j+1].value1*2 == 8:
								board[i][j+1].color = Color(0.94,0.69,0.47)
							if board[i][j+1].value1*2 == 16:
								board[i][j+1].color = Color(0.94,0.53,0.32)
							if board[i][j+1].value1*2 == 32:
								board[i][j+1].color = Color(0.96,0.47,0.36)
							if board[i][j+1].value1*2 == 64:
								board[i][j+1].color = Color(0.97,0.35,0.25)
							if board[i][j+1].value1*2 == 128:
								board[i][j+1].color = Color(0.92,0.81,0.43)
							if board[i][j+1].value1*2 == 256:
								board[i][j+1].color = Color(0.90,0.77,0.34)
							if board[i][j+1].value1*2 == 512:
								board[i][j+1].color = Color(0.92,0.75,0.26)
							if board[i][j+1].value1*2 == 1024:
								board[i][j+1].color = Color(0.94,0.74,0.14)
							if board[i][j+1].value1*2 == 2048:
								board[i][j+1].color = Color(0.96,0.75,0.03)
							if board[i][j+1].value1*2 >= 4096:
								board[i][j+1].color = Color(0.19,0.19,0.19)
							GameEvent.emit_signal("points_gained", board[i][j+1].value1*2)
							board[i][j+1].set_value(board[i][j+1].value1*2)
							board[i][j].free()
						else:
							j-=1
							continue
				j-=1
			i-=1
		for y in range(0, width):
			for x in range(0, height):
				if not is_free(x,y):
					board[x][y].rect_position = get_pos_from_grid_pos(x, y)
		new_turn()
		
signal game_over()

func game_over():
	var i = 0
	while(i<width+height):
		for x in range(0, width-1):
			for y in range(0, height-1):
				if is_free(x, y) or is_free(x+1, y) or is_free(x, y+1):
					return
				if board[x][y].value1 == board[x+1][y].value1:
					return
				if board[x][y].value1 == board[x][y+1].value1:
					return
		i+=1
	emit_signal("game_over")

func new_turn():
	creat_turn_pieces()
	
func creat_turn_pieces():
	for i in range(0, pieces_turn):
		create_piece_random(2)
	
func init_board():
	for i in range(0, initial_pieces):
		create_piece_random(2)

func create_piece_random(value):
	var empty_spots = get_empty_spots()
	if empty_spots.size() == 0:
		return
	empty_spots.shuffle()
	create_piece(value, empty_spots[0].x, empty_spots[0].y)

func get_empty_spots():
	var empty_spots = []
	for x in range(0, width):
		for y in range(0, height):
			if is_free(x, y):
				empty_spots.append(Vector2(x, y))
	return empty_spots

func setup_board():
	for x in range(0, width):
		board.append([])
		for y in range(0, height):
			board[x].append(null)

func create_piece(value, x, y):
	if not is_free(x, y):
		return 
	var piece = Piece.instance()
	piece.set_value(value)
	piece.rect_size = Vector2(piece_width, piece_height)
	piece.rect_position = get_pos_from_grid_pos(x, y)
	board[x][y] = piece
	add_child(piece)
	
func is_free(x, y):
	return board[x][y] == null
	
func get_pos_from_grid_pos(x, y):
	var margin_horizontal = (x+1) * margin
	var margin_vertical = (y+1) * margin
	var offset_horizontal = x * piece_width
	var offset_vertical = y * piece_height
	return Vector2(margin_horizontal+offset_horizontal, margin_vertical + offset_vertical)

func _process(delta):
	move()
	game_over()
