var currentFont = draw_get_font()
var currentcolour = draw_get_color()
draw_set_alpha(image_alpha)
draw_set_font(font)
draw_set_color(colour)
draw_text(x,y,text)
draw_set_alpha(1)

draw_set_font(currentFont)
draw_set_color(currentcolour)

image_alpha -= fade
if (image_alpha < 0)
{
	instance_destroy()
}