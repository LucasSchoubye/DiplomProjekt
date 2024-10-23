// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManDrawScoreline(){

	// Background
	var width = 100
	var height = 30
	draw_roundrect(display_get_gui_width()/2 - width/2, 25, display_get_gui_width()/2 + width/2, 25 + height, false)
	draw_set_color(c_dkgray)
	draw_rectangle(display_get_gui_width()/2 - width/2, 50, display_get_gui_width()/2 + width/2, 50 + height/3, false)

	var clubInitials = string_copy(string_upper(obj_UltManManagerController.clubName), 0, 3)
	var opponentInitials = string_copy(string_upper(obj_UltManManagerController.playerOpponentTeam.clubName), 0, 3)

	draw_set_halign(fa_center)
	draw_set_valign(fa_bottom)
	draw_set_font(fn_scoreline)
	draw_text(view_wport[1]/2,50, clubInitials+": "+string(scoreline[0]) + " - "+opponentInitials+": "+string(scoreline[1]))
	//scr_drawOutlineText(view_wport[1]/2,50, c_black, c_white, clubInitials+": "+string(scoreline[0]) + " - "+opponentInitials+": "+string(scoreline[1]))
	
	draw_set_font(fn_textLatoSmall)
	draw_set_color(c_white)
	var timerString = string(obj_UltManGameController.timer)
	if (string_count(".",timerString) = 0)
		timerString = timerString+".00"
	draw_text(view_wport[1]/2,64,timerString)
	
}