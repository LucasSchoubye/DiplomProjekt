/// @description Insert description here
// You can write your code in this editor
// Setup view variables
var screenTop = 50
var screenMidX = room_width/2
var screenMidY = room_height/2
var categoryWidth = room_width*0.2
var categoryHeight = room_height*0.07
var categoryStartX = room_width*0.01
var categoryStartY = room_height*0.125
var categoryCounter = 0
var backButtonStartY = room_height*0.035
var backButtonHeight = categoryHeight/1.5
var backButtonWidth = categoryWidth/3

draw_text(screenMidX,screenTop,"Fight The FUNgeon")

// Back button
draw_rectangle(categoryStartX,backButtonStartY,categoryStartX + backButtonWidth,backButtonStartY + backButtonHeight,true)
draw_text(categoryStartX + backButtonWidth/2,backButtonStartY+backButtonHeight/2,"Back")
if(mouse_x > categoryStartX && mouse_x < categoryStartX+backButtonWidth) {
		if(mouse_y > backButtonStartY && mouse_y < backButtonStartY+backButtonHeight) {
			draw_set_alpha(0.3)
			draw_rectangle(categoryStartX,backButtonStartY,categoryStartX + backButtonWidth,backButtonStartY + backButtonHeight,false)
			draw_set_alpha(1)
			if (mouse_check_button_pressed(mb_left)){
				room_goto(rm_menu)
			}
		}
	}