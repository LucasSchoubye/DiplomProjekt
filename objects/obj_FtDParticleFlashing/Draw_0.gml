/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(sin(current_time/2))
draw_circle(x,y,40 + lifetime*20,false)
draw_set_alpha(1)

lifetime--
if (lifetime < 0)
	instance_destroy()