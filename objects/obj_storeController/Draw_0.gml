/// @description Insert description here
// You can write your code in this editor

var screenTop = 50
var screenMidX = room_width/2
var screenMidY = room_height/2
var itemStartX = room_width*0.23
var itemStartY = 100
var itemHeight = room_height*0.3
var itemCounter = 0
var itemRow = 0
var itemWidth = room_width*0.15
var categoryWidth = room_width*0.2
var categoryHeight = room_height*0.07
var categoryStartX = room_width*0.01
var categoryStartY = 100
var categoryCounter = 0
var currencyStart = room_width*0.8

if (room = rm_store)
{
draw_text(screenMidX,screenTop,"Store")


draw_text(currencyStart,screenTop, string(balance) + "$")


for (var i = 0; i < ds_list_size(storeElements); ++i) {
    ds_list_find_value(storeElements,i).DrawItem(itemStartX+itemCounter*itemWidth,itemStartY+itemRow*itemHeight+verticalScroll)
	if (mouse_check_button_pressed(mb_left) and mouse_x > itemStartX+itemCounter*itemWidth && mouse_x < itemStartX+itemCounter*itemWidth+itemWidth){
			if(mouse_y > itemStartY+itemRow*itemHeight && mouse_y < itemStartY+itemRow*itemHeight+itemHeight) {
				if(selectedPrice <= balance) {
					audio_play_sound(sou_purchase,1,false, 1, 0.3, 1)
					balance = balance-selectedPrice
					obj_firestore_controller.UpdateStudentInventory()
				}
				else {
					show_message("You need more $$$")
				}
			}
	}
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