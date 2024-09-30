/// @description Insert description here
// You can write your code in this editor
var screenTop = 50
var screenMidX = room_width/2
var screenMidY = room_height/2
var itemStartX = room_width*0.23
var itemStartY = room_height*0.125
var itemHeight = room_height*0.3
var itemCounter = 0
var itemRow = 0
var itemWidth = room_width*0.15
var categoryWidth = room_width*0.2
var categoryHeight = room_height*0.07
var categoryStartX = room_width*0.01
var categoryStartY = room_height*0.125
var categoryCounter = 0
var backButtonStartY = room_height*0.035
var backButtonHeight = categoryHeight/1.5
var backButtonWidth = categoryWidth/3


if(room == rm_minigameMenu) {

draw_text(screenMidX,screenTop,"MINI GAMES!!!")


for (var i = 0; i < ds_list_size(itemElements); ++i) {
    ds_list_find_value(itemElements,i).DrawItem(itemStartX+itemCounter*itemWidth,itemStartY+itemRow*itemHeight+verticalScroll)
	itemCounter++
	if (itemCounter == 5)
    {
        itemCounter = 0
        itemRow++
    }
	
}

for (var i = 0; i < ds_list_size(categoryElements); ++i) {
	ds_list_find_value(categoryElements,i).DrawCategory(categoryStartX,categoryStartY+categoryCounter*categoryHeight)
	categoryCounter++
}

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
if(mouse_wheel_down() || keyboard_check(vk_down)) {
	verticalScroll -= 15
}
else if(mouse_wheel_up() || keyboard_check(vk_up)) {
	verticalScroll += 15
}

}