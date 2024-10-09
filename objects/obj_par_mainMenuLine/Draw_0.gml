/// @description Insert description here
// You can write your code in this editor
if (room = rm_menu)
{
	draw_set_alpha(((y-room_height*0.4)/room_height)*0.9)
	draw_line_color(0,y,room_width,y,obj_mainMenuController.animColor, obj_mainMenuController.animColor)
	y += point_distance(x,y,x,room_height+400)/800

	if (y > room_height)
	{
		y=room_height*0.6+30
	}
	draw_set_alpha(1)
}