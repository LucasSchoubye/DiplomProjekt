/// @description Insert description here
// You can write your code in this editor
var screenTop = 50
var screenMidX = room_width/2
var screenMidY = room_height/2
var categoryWidth = room_width*0.2
var categoryHeight = room_height*0.07
var categoryStartX = room_width*0.01
var categoryStartY = room_height*0.125
var categoryCounter = 0
var currencyStart = room_width*0.8
var	categoryTextStartX =  room_width*0.01
var	categoryCenterY = categoryHeight/2
var	categoryImgStartX = categoryWidth-30
var backButtonStartY = room_height*0.035
var backButtonHeight = categoryHeight/1.5
var backButtonWidth = categoryWidth/3


if(room == rm_FtDLoadoutMenu) {
	

scr_loadoutInventory()

draw_set_color(#191115)
draw_rectangle(0,0,room_width,categoryStartY - 10,false)
draw_set_font(fn_titleLato)
draw_set_color(c_white)
draw_text(screenMidX,screenTop,"Fight The Dungeon Loadout")
draw_set_font(fn_textLato)

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

if(keyboard_check(vk_backspace)) {
	room_goto(rm_menu)
}
if((mouse_wheel_down() || keyboard_check(vk_down)) && verticalScroll >= -itemRow*itemHeight) {
	verticalScroll -= 15
}
else if((mouse_wheel_up() || keyboard_check(vk_up)) && verticalScroll < 0) 
{
	verticalScroll += 15
}

}