/// @description Insert description here
// You can write your code in this editor
var shadowOffset = 5
draw_set_color(c_dkgray)
draw_set_alpha(0.2)
draw_ellipse(animX-sprite_width/2, animY + 10 + shadowOffset, animX+sprite_width/2, animY - 10 + shadowOffset, false)
draw_set_alpha(1)
draw_set_color(c_white)
draw_sprite_ext( sprite_index, image_index, animX, animY+sin(current_time/70)*2, targetFace, image_yscale, image_angle+sin(current_time/100), image_blend, image_alpha)

targetFace += (face - targetFace)/8


// Draw Weapon
draw_sprite_ext(spr_FtDStaff, image_index, animX - 35*targetFace, animY+sin(current_time/140)*6-50, targetFace, image_yscale, image_angle+sin(current_time/200)*4, image_blend, image_alpha)


//draw HP
var hpbarLength = 150
var hpbarThickness = 10
var hpbarOffset = 30
animTargetHp -= (animTargetHp - hp)/10

draw_rectangle(animX - hpbarLength/2,animY + hpbarOffset,animX - hpbarLength/2 + animTargetHp/hp_max*hpbarLength,animY+hpbarOffset+hpbarThickness,false)
draw_rectangle_color(animX - hpbarLength/2,animY + hpbarOffset,animX - hpbarLength/2 + hp/hp_max*hpbarLength,animY+hpbarOffset+hpbarThickness,c_maroon,c_maroon,c_maroon,c_maroon,false)
draw_rectangle(animX - hpbarLength/2,animY + hpbarOffset,animX + hpbarLength/2,animY+hpbarOffset+hpbarThickness,true)

// Animations
animX -= (animX - x)/4
animY -= (animY - y)/4
