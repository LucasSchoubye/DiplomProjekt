/// @description Draw Menu

// 
var buttonWidth = 300
var buttonHeight = 80

// Title
draw_set_font(fn_LatoBold40)
draw_set_halign(fa_center)
draw_text(room_width/2, room_height*0.2, "Match Completed!")
draw_set_font(fn_konk22)
draw_text(room_width/2, room_height*0.2+50, string(scoreline[0])+" - "+string(scoreline[1]))

// Draw text
draw_set_font(fn_textLato)

for (var i = 0; i < ds_list_size(recapList); ++i) 
{
    draw_text((room_width/4)*2.5, room_height*0.45+30*i, ds_list_find_value(recapList,i))
}

obj_characterController.DrawCharacterMenu(room_width/4,room_height*0.75,5)

// Draw button
draw_set_valign(fa_middle)
draw_roundrect((room_width/4)*2.5 - buttonWidth/2,room_height*0.8 - buttonHeight/2,
				(room_width/4)*2.5 + buttonWidth/2,room_height*0.8 + buttonHeight/2,true)
draw_text((room_width/4)*2.5, room_height*0.8, "Get Reward")

// Logic
if (mouse_x > (room_width/4)*2.5 - buttonWidth/2 && 
	mouse_x < (room_width/4)*2.5 + buttonWidth/2 &&
	mouse_y > room_height*0.8 - buttonHeight/2 && 
	mouse_y < room_height*0.8 + buttonHeight/2)
{
	draw_set_alpha(0.2)
	draw_roundrect((room_width/4)*2.5 - buttonWidth/2,room_height*0.8 - buttonHeight/2,
				(room_width/4)*2.5 + buttonWidth/2,room_height*0.8 + buttonHeight/2,false)
	draw_set_alpha(1)
	
	if(mouse_check_button_pressed(mb_left))
	{
		GetReward()
	}
}