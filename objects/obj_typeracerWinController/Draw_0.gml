/// @description Insert description here
// You can write your code in this editor
repeat(6)
{
	var randDir =  random(200) - 10
	var randDist = 300 + random(30)
	var part = instance_create_depth((room_width*0.5 + room_width/2 + sin(current_time/400)*100)/2 + lengthdir_x(randDist,randDir), (room_height*0.6 + room_height*0.7 + sin(current_time/500)*20)/2 + lengthdir_y(randDist,randDir), -10, obj_FtDParticleDust)
	part.speed = 20
	part.direction = randDir
	part.fade = 0.005
	part.shrink = 0.005
	part.image_angle = part.direction
	part.image_xscale = 4
	part.image_yscale = 0.25
	part.friction = 0.15
}

draw_set_font(fn_konk48)
draw_set_color(#191a19)
draw_rectangle(0,room_height*0.6, room_width, room_height,false)

draw_set_color(c_orange)
draw_rectangle_color(0,room_height*0.6, room_width, 0,#7CB2B2,#7CB2B2,c_orange,c_orange,false)

scr_drawOutlineText(room_width/2, room_height*0.2, c_black, c_white,"You placed "+ordinalNumber(global.typeracerPlacement)+"!")

draw_sprite_ext(spr_typeracerWinCar, 0, room_width/2 + sin(current_time/400)*100, room_height*0.7 + sin(current_time/500)*20, 0.3, 0.3, sin(current_time/400)*5, c_white, 1)

// 
draw_set_font(fn_konk22)
scr_drawOutlineText(room_width/2, room_height*0.2 + 60, c_black, c_white,"You win "+string(400 - global.typeracerPlacement*75)+" Content Coins!")


// Draw button
var buttonMiddleX = room_width/2
var buttonMiddleY = room_height*0.85
var buttonWidth = 200
var buttonHeight = 50

draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_roundrect(buttonMiddleX - buttonWidth/2, buttonMiddleY + buttonHeight/2,buttonMiddleX + buttonWidth/2, buttonMiddleY - buttonHeight/2,true)
draw_set_alpha(0.2 + sin(current_time/200)*0.05)
draw_roundrect(buttonMiddleX - buttonWidth/2, buttonMiddleY + buttonHeight/2,buttonMiddleX + buttonWidth/2, buttonMiddleY - buttonHeight/2,false)
draw_set_alpha(1)


draw_text(buttonMiddleX, buttonMiddleY, "OK")

if (mouse_x > buttonMiddleX - buttonWidth/2 &&
	mouse_y < buttonMiddleX + buttonWidth/2 &&
	mouse_y > buttonMiddleY - buttonHeight/2 &&
	mouse_y < buttonMiddleY + buttonHeight/2)
{
	draw_set_alpha(0.3)
	draw_roundrect(buttonMiddleX - buttonWidth/2, buttonMiddleY + buttonHeight/2,buttonMiddleX + buttonWidth/2, buttonMiddleY - buttonHeight/2,false)
	draw_set_alpha(1)

	if (mouse_check_button_pressed(mb_left))
	{
		window_set_cursor(cr_default)
		cursor_sprite = -1
		audio_stop_all()
		room_goto(rm_minigameMenu)
	}
}
