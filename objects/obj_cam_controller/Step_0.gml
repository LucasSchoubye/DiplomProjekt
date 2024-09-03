/// @description Go to Player

if (instance_exists(obj_player))
{
	x += ((obj_player.x*3 + mouse_x)/4 - x)/10
	y += ((obj_player.y*3 + mouse_y)/4 - y)/10
}