// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawOutlineText(X, Y, outlineColor, textColor, text){

	// Outline
	draw_set_color(outlineColor)
	draw_text(X+2,Y,text)
	draw_text(X-2,Y,text)
	draw_text(X,Y+2,text)
	draw_text(X,Y-2,text)

	// Draw text
	draw_set_color(textColor)
	draw_text(X,Y,text)
	
	
}