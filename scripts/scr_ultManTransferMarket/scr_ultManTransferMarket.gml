// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_ultManTransferMarket(){
	
	var Packs = ["Gold", "Silver", "Bronze"]
	
	// get current settings
	var currentColour = draw_get_color()
	var currentVAlign = draw_get_valign()
	var currentHAlign = draw_get_halign()
	var currentFont = draw_get_font()
	var currentAlpha = draw_get_alpha()
	
	var matchBoxTop = room_height * 0.1;
	var matchBoxBottom = room_height * 1;
	var matchBoxLeft = room_width * 0.2;
	var matchBoxRight = room_width * 0.7;
	
	var sellBoxTop = room_height * 0.1;
	var sellBoxBottom = room_height * 1;
	var sellBoxLeft = room_width * 0.7;
	var sellBoxRight = room_width * 1;
	
	// draw boxes
	draw_rectangle(matchBoxLeft, matchBoxTop, matchBoxRight, matchBoxBottom, true)
	
	draw_rectangle(sellBoxLeft, sellBoxTop, sellBoxRight, sellBoxBottom, true)
	
	//for (var i = 0; i < array_length(Packs); ++i) {
		
	//	x1val = 
	//	x1 = room_height * 0.1
		
	//	draw_roundrect_color(x1,y1,x2,y2, colour,colour, false )
		
	//}
	
	//draw_roundrect_color(x1,y1,x2,y2, colour,colour, false )
	
	// reset stuff
	draw_set_valign(currentVAlign)
	draw_set_halign(currentHAlign)
	draw_set_color(currentColour)
	draw_set_font(currentFont)
	draw_set_alpha(currentAlpha)
	
}