/// @description Insert description here
// You can write your code in this edito

var backgroundColor = #191115
//#191115

// Skip tutorial
if (ds_list_find_index(obj_menuGridController.tutorialsPlayed, tutorialArray[0].title) > -1)
	room_goto(textStruct.roomRef)

// Draw Background
draw_set_alpha(0.3)
draw_rectangle_color(0,0,room_width,room_height*0.3, c_white, c_white, backgroundColor, backgroundColor, false)
draw_rectangle_color(0,room_height*0.7,room_width,room_height, backgroundColor, backgroundColor, c_white, c_white, false)

// Draw Picture
var pictureTop = room_height*0.15
var pictureBot = room_height*0.75
var pictureLeft = room_width*0.025
var pictureRight = room_width*0.65

draw_set_alpha(1)
image_speed = 0.5

// Draw picture
draw_sprite_stretched(textStruct.gif, image_index, pictureLeft, pictureTop, pictureRight -pictureLeft, pictureBot - pictureTop)
draw_roundrect(pictureLeft, pictureTop, pictureRight, pictureBot, true)

// Draw control box
draw_set_alpha(0.15)
draw_rectangle(pictureRight+1,room_height*0.2,room_width,room_height*0.725,false)
draw_set_alpha(1)
draw_rectangle(pictureRight+1,room_height*0.2,room_width,room_height*0.725,true)
draw_set_color(c_white)

// Draw Title and Controls
draw_set_font(fn_titleLato)
draw_set_valign(fa_middle)
draw_set_halign(fa_left)
scr_drawOutlineText(room_width*0.015, room_height*0.075, c_black, c_white, textStruct.title)
draw_set_font(fn_lato16)
//draw_text(pictureRight + 10, room_height*0.25, "Controls:")
scr_drawOutlineText(pictureRight + 10, room_height*0.25, c_black, c_white,  "Controls:")
scr_drawOutlineText(pictureLeft + 200, pictureBot + 30, c_black, c_white,  "Goal:")

// Paragraf
draw_set_font(fn_textLato)
draw_set_valign(fa_top)
draw_text_ext(pictureLeft + 200, pictureBot + 65, textStruct.goalParagraf, string_height("I")+2,room_width*0.4)
draw_text_ext(pictureRight + 20, room_height*0.25 + 35, textStruct.controlParagraf, string_height("I")*2+2,room_width*0.5)

// Character
obj_characterController.DrawCharacterMenu(room_width*0.075, room_height, 2)

// Draw button
var buttonMiddleX = pictureRight + (room_width-pictureRight)/2
var buttonMiddleY = pictureBot + (room_height-pictureBot)/2
var buttonWidth = 200
var buttonHeight = 50

draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_roundrect(buttonMiddleX - buttonWidth/2, buttonMiddleY + buttonHeight/2,buttonMiddleX + buttonWidth/2, buttonMiddleY - buttonHeight/2,true)
draw_set_alpha(0.2 + sin(current_time/200)*0.05)
draw_roundrect(buttonMiddleX - buttonWidth/2, buttonMiddleY + buttonHeight/2,buttonMiddleX + buttonWidth/2, buttonMiddleY - buttonHeight/2,false)
draw_set_alpha(1)

if (currentTutorialScreen = tutorialScreens)
	draw_text(buttonMiddleX, buttonMiddleY, "Play")
else
	draw_text(buttonMiddleX, buttonMiddleY, "Next")

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
		if(currentTutorialScreen = tutorialScreens)
		{
			room_goto(textStruct.roomRef)
			ds_list_add(obj_menuGridController.tutorialsPlayed, tutorialArray[0].title)
		}
		else
		{
			currentTutorialScreen++
			textStruct = tutorialArray[currentTutorialScreen-1]
		}
	}
}


// Back button
var buttonMiddleX = room_width*0.95
var buttonMiddleY = room_height*0.05
var buttonWidth = 100
var buttonHeight = 25

draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_roundrect(buttonMiddleX - buttonWidth/2, buttonMiddleY + buttonHeight/2,buttonMiddleX + buttonWidth/2, buttonMiddleY - buttonHeight/2,true)
draw_set_alpha(1)

draw_text(buttonMiddleX, buttonMiddleY, "Back")

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
		room_goto(rm_minigameMenu)
	}
}