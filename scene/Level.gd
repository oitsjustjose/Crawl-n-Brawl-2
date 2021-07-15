extends Node2D

var possible_decos = [
	load("res://assets/frames/wall_banner_blue.png"),
	load("res://assets/frames/wall_banner_red.png"),
	load("res://assets/frames/wall_banner_yellow.png"),
	load("res://assets/frames/wall_banner_green.png"),
	load("res://assets/frames/floor_1.png"),
	load("res://assets/frames/floor_2.png"),
	load("res://assets/frames/floor_3.png"),
	load("res://assets/frames/floor_4.png"),
	load("res://assets/frames/floor_5.png"),
	load("res://assets/frames/floor_6.png"),
	load("res://assets/frames/floor_7.png"),
	load("res://assets/frames/floor_8.png")
]

onready var bg = get_node("Background/BG/ParallaxLayer/TextureRect")
onready var decorations = [
	get_node("Deco1"),
	get_node("Deco2"),
	get_node("Deco3")
]

func smart_snap(num, scale, max_val):
	"""
	This makes it such that a number is snapped
	"""
	var mod = 1
	if num + scale > max_val:
		mod = -1
	
	while num % scale != 0:
		num += (mod * 1)
		
	return num

func _ready():
	# Color tinting related things :D
	var rand = RandomNumberGenerator.new()
	rand.seed = hash(OS.get_time())
	var LevelCol = Color(
		rand.randf_range(0.0, 1.0), 
		rand.randf_range(0.0, 1.0), 
		rand.randf_range(0.0, 1.0)
	)
	
	print("Picked color (%s %s %s)" % [LevelCol.r, LevelCol.g, LevelCol.b])
	
	bg.modulate = LevelCol
	
	for deco in decorations:
		var texture = possible_decos[rand.randi_range(0 ,len(possible_decos))]
		var x = smart_snap(rand.randi_range(0, 1024), 64, 1024)
		var y = smart_snap(rand.randi_range(0, 600), 64, 600)
		deco.set_texture(texture)	
		deco.position = Vector2(x, y)
		deco.scale = Vector2(4.0, 4.0)
		deco.modulate = LevelCol
	
	
