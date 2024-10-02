function scr_drawButton(x1,y1,x2,y2,text){
	
	var currentFont = draw_get_font()
	var currentHAlign = draw_get_halign()
	var currentVAlign = draw_get_valign()
	
	draw_set_font(fn_buttonOpenSans);
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_roundrect(x1,y1,x2,y2, false)
	draw_set_color(c_white)
	draw_text((x1 + x2)/2, (y1 + y2)/2, text)
	
	draw_set_halign(currentHAlign)
	draw_set_valign(currentVAlign)
	draw_set_font(currentFont)
	
	if (mouse_x > x1 && mouse_x < x2 &&mouse_y > y1 && mouse_y < y2)
	{
		draw_set_color(c_black)
		draw_set_alpha(0.15)
		draw_roundrect(x1,y1,x2,y2, false)
		if (mouse_check_button_pressed(mb_left)){
			draw_set_alpha(1)
			draw_set_color(c_white)
			return true
		}
		draw_set_alpha(1)
	}
	draw_set_color(c_white)
	return false
}