/// @description Insert description here
// You can write your code in this editor

draw_self()

// Fade with time
image_alpha = curLifetime/startLifetime
image_xscale = image_alpha*0.8
image_yscale = image_alpha*0.8
curLifetime -= decaySpd

if (curLifetime < 0)
{
	instance_destroy()
}