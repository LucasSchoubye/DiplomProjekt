
// Button position and size
var LC = obj_languageController

var buttonX = room_width * 0.85
var buttonY = room_height * 0.035
var buttonX2 = room_width * 0.9925
var buttonY2 = room_height * 0.0965
var titleHeight = (string_height(obj_UltManManagerController.clubName) / 2)
var buttonText = LC.translate("Play next half")

// Title
draw_set_font(fn_LatoBold40)
draw_set_halign(fa_center)
draw_text(room_width/2, room_height*0.05, LC.translate("Halftime: ")+string(scoreline[0])+" - "+string(scoreline[1]))


with(obj_UltManManagerController)
{
	scr_ultManTactics(true)	
}

// Draw button
draw_set_valign(fa_middle)
draw_set_font(fn_LatoSemiBold12)

draw_set_color(#3B95FF)
scr_drawButton(buttonX, buttonY - titleHeight,buttonX2, buttonY2 - titleHeight, buttonText )
draw_set_color(#ffffff)
// Logic
if (mouse_x > buttonX && mouse_x < buttonX2 && mouse_y > buttonY - titleHeight && mouse_y < buttonY2 - titleHeight)
{
	draw_set_alpha(0.2)
	draw_roundrect(buttonX,buttonY - titleHeight,buttonX2,buttonY2 - titleHeight,false)
	draw_set_alpha(1)
	
	if(mouse_check_button_pressed(mb_left))
	{
		PlaySecondHalf()
	}
}