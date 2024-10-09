/// @description Draw Menu

// 
var buttonWidth = 150
var buttonHeight = 60
var buttonX = (room_width/10)*9
var buttonY = room_height*0.1

// Title
draw_set_font(fn_LatoBold40)
draw_set_halign(fa_center)
draw_text(room_width/2, room_height*0.05, "Halftime: "+string(scoreline[0])+" - "+string(scoreline[1]))

// 
with(obj_UltManManagerController)
{
	scr_ultManTactics()	
}

// Draw button
draw_set_valign(fa_middle)
draw_set_font(fn_LatoSemiBold12)
draw_roundrect(buttonX - buttonWidth/2,buttonY - buttonHeight/2,
				buttonX + buttonWidth/2,buttonY + buttonHeight/2,true)
draw_text(buttonX, buttonY, "Play next half")

// Logic
if (mouse_x > buttonX - buttonWidth/2 && 
	mouse_x < buttonX + buttonWidth/2 &&
	mouse_y > buttonY - buttonHeight/2 && 
	mouse_y < buttonY + buttonHeight/2)
{
	draw_set_alpha(0.2)
	draw_roundrect(buttonX - buttonWidth/2,buttonY - buttonHeight/2,
				buttonX + buttonWidth/2,buttonY + buttonHeight/2,false)
	draw_set_alpha(1)
	
	if(mouse_check_button_pressed(mb_left))
	{
		PlaySecondHalf()
	}
}