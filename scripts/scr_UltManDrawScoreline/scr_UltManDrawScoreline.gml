// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManDrawScoreline(){

	draw_set_halign(fa_center)
	draw_set_font(fn_RobotoBlack8)
	draw_text(view_wport[1]/2,50,"ARS: "+string(scoreline[0]) + " - "+"MAN: "+string(scoreline[1]))
	
	var timerString = string(obj_UltManGameController.timer)
	if (string_count(".",timerString) = 0)
		timerString = timerString+".00"
	draw_text(view_wport[1]/2,70,timerString)

}