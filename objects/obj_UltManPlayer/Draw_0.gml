
draw_set_color(c_black)
draw_set_alpha(0.4)
draw_ellipse(x-30,y-10,x+30,y+10,false)
for (var i = 0; i < 4; ++i) {
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, 1, 45 + 90*i, c_black, 0.02)
}
draw_set_alpha(0.4)
draw_set_color(c_white)

// Positioning
x -= (x-targetX)/10
y -= (y-targetY)/10
image_xscale -= (image_xscale-facing)/3

// Role coordinates
scr_UltManSetPositionCoordinates(position,playerTeam)

// Calculation
targetSpd = point_distance(targetX, targetY, mouse_x, mouse_y)/2
if (targetSpd > topSpd){targetSpd = topSpd}
targetShootSpd = point_distance(targetX, targetY, mouse_x, mouse_y)/1.15
if (targetShootSpd > topPassSpd){targetShootSpd = topPassSpd}

// animation
depth = -y
animCycle++
draw_sprite_ext(sprite_index, 0, x, y + sin(animCycle/5)*10, image_xscale, 1, image_angle + sin(animCycle/10)*3, image_blend, 1)
image_angle = image_angle/1.08

// Draw selected
if (obj_UltManBall.owner = id)
{
	draw_set_alpha(0.5 + sin(current_time/80)*0.2)
	if (playerTeam)
		draw_triangle_color(x-20,y-290, x,y-250, x+20,y-290, c_aqua, c_aqua, c_aqua, false)
	else
		draw_triangle_color(x-20,y-290, x,y-250, x+20,y-290, c_red, c_red, c_red, false)
	draw_set_alpha(1)
}

// Draw acceleration
accX = lengthdir_x(lastMoveLen, lastMoveDir)*0.4
accY = lengthdir_y(lastMoveLen, lastMoveDir)*0.4

// Draw name
draw_set_alpha(1)
draw_set_halign(fa_center)
draw_set_font(fn_LatoBold40)
draw_text(x, y + 90, name[1])