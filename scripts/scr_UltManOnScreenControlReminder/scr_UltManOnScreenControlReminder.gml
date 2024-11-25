// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManOnScreenControlReminder(){
	
	var iconSize = 30
	var iconTextBuffer = 40
	var LC = obj_languageController
	
	draw_set_halign(fa_left)

	// left click
	draw_sprite_stretched(spr_iconLeftClick,0,17,display_get_gui_height() - 40,iconSize,iconSize)
	draw_text(17 + iconTextBuffer, display_get_gui_height() - 40 + 15, LC.translate("Left Click: Move Player"))
	
	// Right Click
	draw_sprite_stretched(spr_iconRightClick,0,20,display_get_gui_height() - 80,iconSize,iconSize)
	draw_text(20 + iconTextBuffer,display_get_gui_height() - 80 + 15, LC.translate("Drag Right Click: Make teammate move"))
	
	// Shift
	draw_sprite_stretched(spr_iconShift,0,20,display_get_gui_height() - 120,iconSize,iconSize)
	draw_text(20 + iconTextBuffer,display_get_gui_height() - 120 + 15, LC.translate("Hold Shift: Shoot/Pass"))
	
}