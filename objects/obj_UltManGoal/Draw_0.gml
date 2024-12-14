/// @description Insert description here
// You can write your code in this editor



if (x > room_width/2)
{
	facing = -1
}

draw_rectangle(x - goalDepth*facing, y - goalHeight/2, x, y + goalHeight/2, true)

// Draw bot net
draw_line(x - goalDepth*facing*0.7, y + goalHeight/6, x, y + goalHeight/6)
draw_line(x - goalDepth*facing*0.7, y + goalHeight/6, x - goalDepth*facing, y + goalHeight/2)

// draw top net
draw_line(x - goalDepth*facing*0.7, y - goalHeight + goalHeight/6, x, y - goalHeight + goalHeight/6)
draw_line(x - goalDepth*facing*0.7, y - goalHeight + goalHeight/6, x - goalDepth*facing, y - goalHeight/2)

// draw net
draw_set_alpha(0.3)
draw_rectangle(x - goalDepth*facing*0.7, y + goalHeight/2, x, y - goalHeight + goalHeight/6, false)
draw_rectangle(x - goalDepth*facing*0.7, y + goalHeight/6, x, y - goalHeight + goalHeight/6, false)
draw_triangle(x - goalDepth*facing*0.7, y - goalHeight + goalHeight/6,  x - goalDepth*facing*0.7, y - goalHeight/2, x - goalDepth*facing, y - goalHeight/2, false)
draw_rectangle(x - (goalDepth)*facing, y - goalHeight/2,x - (goalDepth - 2)*facing*0.7, y + goalHeight/2, false)
draw_set_alpha(1)