/// @description Insert description here
// You can write your code in this editor

draw_self()

image_alpha -= fade
if (image_alpha > 0)
{
	image_xscale += shrink
	image_yscale += shrink
}

image_blend = get_fire_color(image_alpha)

if (image_alpha < 0)
{
	instance_destroy()
}