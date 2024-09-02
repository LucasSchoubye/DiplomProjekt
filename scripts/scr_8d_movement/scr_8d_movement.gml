// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_8d_movement(){

var _left = keyboard_check(ord("A")); 
var _right = keyboard_check(ord("D"));
var _up = keyboard_check(ord("W"));
var _down = keyboard_check(ord("S"));
var _hspd = _right - _left;
var _vspd = _down - _up;

var _anim_left = spr_pokemon_character_L;
var _anim_right = spr_pokemon_character_R;
var _anim_down = spr_pokemon_character_D;
var _anim_up = spr_pokemon_character_U;

	if (_hspd != 0 || _vspd != 0)
	{
		// Sprinting
	    var _spd = 6;
		if (keyboard_check(vk_shift))
			_spd = 8;
		
	    var _dir = point_direction(0, 0, _hspd, _vspd);
	    var _xadd = lengthdir_x(_spd, _dir);
	    var _yadd = lengthdir_y(_spd, _dir);
		
		move_contact_solid(_dir, _spd)
		
		
		if (_vspd < 0)
		{
			sprite_index = _anim_up
		}
		else if (_vspd > 0)
		{
			sprite_index = _anim_down
		}
		
		if (_hspd < 0)
		{
			sprite_index = _anim_left
		}
		else if (_hspd > 0)
		{
			sprite_index = _anim_right
		}
		
		// Animation
		walk_cycle++
	}
}