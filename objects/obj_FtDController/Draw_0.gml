/// @description Insert description here
// You can write your code in this editor
if(keyboard_check(vk_backspace)) {
	room_goto(rm_menu)
}


var camX = camera_get_view_x(camera_get_active())
var camY = camera_get_view_y(camera_get_active())

draw_text(camX, camY, "YOYOYO")