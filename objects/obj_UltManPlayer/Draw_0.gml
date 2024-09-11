
draw_set_color(c_black)
draw_set_alpha(0.4)
draw_ellipse(x-30,y-10,x+30,y+10,false)
draw_set_alpha(0.4)
draw_set_color(c_white)

// Positioning
x -= (x-targetX)/10
y -= (y-targetY)/10
image_xscale -= (image_xscale-facing)/3

// Calculation
targetSpd = point_distance(targetX, targetY, mouse_x, mouse_y)/2
if (targetSpd > topSpd){targetSpd = topSpd}
targetShootSpd = point_distance(targetX, targetY, mouse_x, mouse_y)/1.5
if (targetShootSpd > topShootSpd){targetShootSpd = topShootSpd}

// animation
depth = -y
animCycle++
draw_sprite_ext(sprite_index, 0, x, y + sin(animCycle/5)*10, image_xscale, 1, 0 + sin(animCycle/10)*3, image_blend, 1)

