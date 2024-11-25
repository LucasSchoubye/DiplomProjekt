// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawQuestionHint(X1,Y1,X2,Y2){

	var prevFont = draw_get_font()
	var prevValign = draw_get_valign()
	
	draw_set_alpha(0.85)
	draw_roundrect(X1,Y1,X2,Y2,false)
	draw_set_alpha(1)
	draw_roundrect(X1,Y1,X2,Y2,true)
	
	draw_set_color(c_black)
	//draw_set_font(fn_textLato)
	draw_set_valign(fa_middle)
	draw_text_ext((X2+X1)/2, (Y1+Y2)/2, scr_mathErroEnumToDescription(global.LastMistakeType), string_height("I")*1.5, abs(X1 - X2) - 30)
	

	draw_set_font(prevFont)
	draw_set_valign(prevValign)
	draw_set_color(c_white)
}