/// @description Insert description here
// You can write your code in this editor
var shadowOffset = 5
draw_set_color(c_dkgray)
draw_set_alpha(0.2)
draw_ellipse(x-sprite_width/2, y + 10 + shadowOffset, x+sprite_width/2, y - 10 + shadowOffset, false)
draw_set_alpha(1)
draw_set_color(c_white)
draw_sprite_ext( sprite_index, image_index, x, y+sin(current_time/70)*2, targetFace, image_yscale, image_angle+sin(current_time/100), image_blend, image_alpha)

targetFace += (face - targetFace)/8


// Draw Weapon
draw_sprite_ext(spr_FtDStaff, image_index, x - 35*targetFace, y+sin(current_time/140)*6-50, targetFace, image_yscale, image_angle+sin(current_time/200)*4, image_blend, image_alpha)


//draw HP
var hpbarLength = 150
var hpbarThickness = 10
var hpbarOffset = 30
animTargetHp -= (animTargetHp - hp)/10

draw_rectangle(x - hpbarLength/2,y + hpbarOffset,x - hpbarLength/2 + animTargetHp/hp_max*hpbarLength,y+hpbarOffset+hpbarThickness,false)
draw_rectangle_color(x - hpbarLength/2,y + hpbarOffset,x - hpbarLength/2 + hp/hp_max*hpbarLength,y+hpbarOffset+hpbarThickness,c_maroon,c_maroon,c_maroon,c_maroon,false)
draw_rectangle(x - hpbarLength/2,y + hpbarOffset,x + hpbarLength/2,y+hpbarOffset+hpbarThickness,true)
/*
var _healthPercent = hp/hp_max
var _hpImage = (sprite_get_number(spr_enemyHealth_1)-1) * _healthPercent
draw_sprite(spr_enemyHealth_1,_hpImage,x,y-125)
