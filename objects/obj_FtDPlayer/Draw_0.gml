/// @description Insert description here
// You can write your code in this editor
//draw_self()

// Draw shadow
var shadowOffset = 25
draw_set_color(c_dkgray)
draw_set_alpha(0.2)
draw_ellipse(x-sprite_width/2, y + 10 + shadowOffset, x+sprite_width/2, y - 10 + shadowOffset, false)
draw_set_alpha(1)
draw_set_color(c_white)

// Draw Player
draw_sprite_ext(sprite_index, 0, x, y + sin(animCycle)*6, targetFacing, 1, -lean*targetFacing, c_white, 1)

// Draw Weapon
draw_sprite_ext(weaponSprite, 0, x, y - 20 + sin(animCycle)*8 + sin(current_time/400)*6, targetFacing, 1, lean*targetFacing*3.8, c_white, 1)

// Dust
if (smokeTimer < 0)
{
	smokeTimer = 10
	instance_create_depth(x,y+shadowOffset,depth + 10,obj_FtDParticleDust)
}

// Animation
facing -= (facing - targetFacing)/3
lean -= (lean - targetLean)/30