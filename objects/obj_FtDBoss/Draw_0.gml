/// @description Insert description here
// You can write your code in this editor

draw_sprite_ext( sprite_index, image_index, x,y, face, image_yscale, image_angle, image_blend, image_alpha)

//draw HP
var _healthPercent = hp/hp_max
var _hpImage = (sprite_get_number(spr_enemyHealth_1)-1) * _healthPercent
draw_sprite(spr_enemyHealth_1,_hpImage,x,y-125)
