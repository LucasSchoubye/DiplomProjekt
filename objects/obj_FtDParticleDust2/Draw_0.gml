/// @description Insert description here
// You can write your code in this editor

draw_self()

image_alpha -= 0.1
image_xscale -= 0.2
image_yscale -= 0.2


if (image_alpha < 0)
{
	instance_destroy()
}