extends 'Base.gd'

export(float) var move_speed = 500
export(float) var jump_impulse = 1500
export(float) var gravity = 100

onready var player_texture = get_node("PlayerSprite")
onready var player_sounds = get_node("AudioStream")

# Other resources -- this will need to be updated for mainhand as well
var JumpSound = preload('res://assets/sounds/player_jump.wav')

var vel : Vector2

var facing_left = false
var moving = false

func _physics_process(_delta):
	var should_jump = Input.is_action_just_pressed("jump")
	var next_move = vel
	var axis = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	# Animate movement
	if axis.x == 0 and moving:
		player_texture.texture = load('res://assets/anim/PlayerIdle.tres')
		moving = false
	elif axis.x != 0 and not moving:
		player_texture.texture = load('res://assets/anim/PlayerWalk.tres')
		moving = true
	
	# If going left
	if axis.x < 0 and not facing_left:
		player_texture.set_flip_h( true )
		facing_left = true
	elif axis.x > 0 and facing_left:
		player_texture.set_flip_h( false )
		facing_left = false
	
	next_move.x = axis.x * move_speed
	next_move.y += gravity
	
	if self.is_on_floor() and should_jump:
		next_move.y -= jump_impulse
		player_sounds.stream = JumpSound
		player_sounds.play()
		
	
	vel = move_and_slide_with_snap(next_move, Vector2.DOWN, Vector2.UP)
