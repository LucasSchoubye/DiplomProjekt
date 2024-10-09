// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManDrawScoreline(){

	var clubInitials = string_copy(string_upper(obj_UltManManagerController.clubName), 0, 3)
	var opponentInitials = string_copy(string_upper(obj_UltManManagerController.playerOpponentTeam.clubName), 0, 3)

	draw_set_halign(fa_center)
	draw_set_font(fn_RobotoBlack8)
	draw_text(view_wport[1]/2,50, clubInitials+": "+string(scoreline[0]) + " - "+opponentInitials+": "+string(scoreline[1]))
	
	var timerString = string(obj_UltManGameController.timer)
	if (string_count(".",timerString) = 0)
		timerString = timerString+".00"
	draw_text(view_wport[1]/2,70,timerString)

}