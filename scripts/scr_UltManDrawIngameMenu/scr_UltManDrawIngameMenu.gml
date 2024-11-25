// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManDrawIngameMenu(){

	// Draw button
	draw_set_font(fn_RobotoBlack8)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_roundrect(5,5,30,30,true)
	draw_set_alpha(0.8)
	draw_roundrect(5,5,30,30,false)
	draw_set_alpha(1)
	draw_set_color(c_white)
	
	var scale = (camera_get_view_width(view_camera[0])/view_wport[0])*1.2

	draw_sprite_stretched_ext(spr_iconSettings,0,6,6,25,25,#FFFFF9,1)
	
	if (camera_get_view_x(view_camera[0]) + 5 * scale < mouse_x &&
		camera_get_view_x(view_camera[0]) + 30 * scale > mouse_x &&
		camera_get_view_y(view_camera[0]) + 5 * scale < mouse_y &&
		camera_get_view_y(view_camera[0]) + 30 * scale > mouse_y &&
		mouse_check_button_pressed(mb_left))
	{
		cursor_sprite = spr_UltManCursor
		room_goto(rm_UltManOverview)
	}
	

}