/// @description Insert description here
// You can write your code in this editor

draw_self()

image_alpha -= 0.01
if (image_xscale > 0)
{
	image_xscale -= 0.05
	image_yscale -= 0.05
}

if (image_alpha < 0)
{
	instance_destroy()
}