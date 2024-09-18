/// @description Insert description here
// You can write your code in this editor

var goalHeight = room_height*0.15
var goalDepth = 300
var facing = 1

if (x > room_width/2)
{
	facing = -1
}

draw_rectangle(x - goalDepth*facing, y - goalHeight/2, x, y + goalHeight/2, true)