// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_anim_player_look()
{
var _anim_left = spr_pokemon_character_L;
var _anim_right = spr_pokemon_character_R;
var _anim_down = spr_pokemon_character_D;
var _anim_up = spr_pokemon_character_U;

var x_border = 100
var y_border = 200


	if (mouse_x + x_border< x)
	{
		sprite_index = _anim_left
	}
	else if (mouse_x - x_border> x)
	{
		sprite_index = _anim_right
	}

	if (mouse_y + y_border< y)
	{
		sprite_index = _anim_up
	}
	else if (mouse_y - y_border> y)
	{
		sprite_index = _anim_down
	}
}