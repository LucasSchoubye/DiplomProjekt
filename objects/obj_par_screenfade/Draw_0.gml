/// @description Insert description here
// You can write your code in this editor
depth = -10000
liveTime++

draw_set_alpha(1 - liveTime/fadeTime)
draw_set_color(c_black)
draw_rectangle(0,0,room_width,room_height,false)
draw_set_color(c_white)
draw_set_alpha(1)

if (liveTime > fadeTime)
	instance_destroy()