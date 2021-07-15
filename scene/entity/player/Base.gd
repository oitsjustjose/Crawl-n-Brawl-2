extends KinematicBody2D

var weapons = {
	"anime_sword": 		load("res://assets/weapons/weapon_anime_sword.png"),
	"axe": 				load("res://assets/weapons/weapon_axe.png"),
	"baton_with_spikes": load("res://assets/weapons/weapon_baton_with_spikes.png"),
	"big_hammer": 		load("res://assets/weapons/weapon_big_hammer.png"),
	"cleaver": 			load("res://assets/weapons/weapon_cleaver.png"),
	"golden_sword": 		load("res://assets/weapons/weapon_golden_sword.png"),
	"hammer": 			load("res://assets/weapons/weapon_hammer.png"),
	"katana": 			load("res://assets/weapons/weapon_katana.png"),
	"knife": 			load("res://assets/weapons/weapon_knife.png"),
	"knight_sword": 		load("res://assets/weapons/weapon_knight_sword.png"),
	"lavish_sword": 		load("res://assets/weapons/weapon_lavish_sword.png"),
	"mace": 				load("res://assets/weapons/weapon_mace.png"),
	"machete": 			load("res://assets/weapons/weapon_machete.png"),
	"red_gem_sword": 	load("res://assets/weapons/weapon_red_gem_sword.png"),
	"regular_sword": 	load("res://assets/weapons/weapon_regular_sword.png"),
	"rusty_sword": 		load("res://assets/weapons/weapon_rusty_sword.png"),
	"saw_sword": 		load("res://assets/weapons/weapon_saw_sword.png"),
	"spear": 			load("res://assets/weapons/weapon_spear.png")
}

# TODO: TMP Remove
var cur_idx = 0
var weapon_names = weapons.keys()
var click_cnt = 0

func _ready():
	Input.set_custom_mouse_cursor(weapons.spear)

func _physics_process(delta):
	var is_clicking = Input.get_action_strength("primary_click") == 1
	if is_clicking:
		click_cnt += 1
		if click_cnt == 25:
			click_cnt = 0
			cur_idx += 1
			if cur_idx >= len(weapon_names):
				cur_idx = 0
			change_held_item(weapon_names[cur_idx])
	
func change_held_item(held_item):
	Input.set_custom_mouse_cursor(weapons[held_item])
