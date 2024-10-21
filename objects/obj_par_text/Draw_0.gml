/// @description Insert description here
// You can write your code in this editor
draw_set_alpha(image_alpha)
draw_text(x,y,text)
draw_set_alpha(1)

image_alpha -= fade
if (image_alpha < 0)
{
	instance_destroy()
}