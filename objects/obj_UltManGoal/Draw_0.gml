/// @description Insert description here
// You can write your code in this editor

if (x > room_width/2)
{
	facing = -1
}

draw_rectangle(x - goalDepth*facing, y - goalHeight/2, x, y + goalHeight/2, true)