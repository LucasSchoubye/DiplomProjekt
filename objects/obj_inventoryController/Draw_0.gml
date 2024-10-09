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


if(room == rm_inventory) {
	if(balance != obj_storeController.balance){
		balance = obj_storeController.balance
		obj_firestore_controller.UpdateBalance()
	}
	

draw_text(screenMidX,screenTop,"Inventory")
draw_text(currencyStart,screenTop, string(balance) + "$")


for (var i = 0; i < ds_list_size(categoryElements); ++i) {
	
	// Draw Category
	draw_set_font(fn_textLato)
	draw_set_alpha(0.1)
	draw_set_color(c_white)
	draw_roundrect(categoryStartX,categoryStartY + i*categoryHeight,categoryStartX+categoryWidth,categoryStartY+categoryHeight+i*categoryHeight,false)
	draw_set_alpha(0.4 + sin(current_time/500)*0.1)
	draw_roundrect(categoryStartX,categoryStartY + i*categoryHeight,categoryStartX+categoryWidth,categoryStartY+categoryHeight+i*categoryHeight,true)
	draw_set_alpha(1)
	draw_set_halign(fa_center)
	draw_text(categoryStartX+categoryWidth/2,categoryStartY+categoryCenterY+i*categoryHeight,ds_list_find_value(categoryElements,i))
	draw_set_halign(fa_center)
	
	// Category logic
	if(mouse_x > categoryStartX && mouse_x < categoryStartX+categoryWidth) {
		if(mouse_y > categoryStartY + i*categoryHeight && mouse_y < categoryStartY+categoryHeight+ i*categoryHeight) {
			draw_set_alpha(0.3)
			draw_rectangle(categoryStartX,categoryStartY + i*categoryHeight,categoryStartX+categoryWidth,categoryStartY+categoryHeight+ i*categoryHeight,false)
			draw_set_alpha(1)
			if (mouse_check_button_pressed(mb_left)){
				currentCategory = i;
				verticalScroll = 0
			}
		}
	}
	
	// Active Category
	draw_set_alpha(0.15)
	draw_rectangle(categoryStartX,categoryStartY + currentCategory*categoryHeight,categoryStartX+categoryWidth,categoryStartY+categoryHeight+ currentCategory*categoryHeight,false)
	draw_set_alpha(1)
}

scr_inventoryCategories()

draw_set_color(#191115)
draw_rectangle(0,0,room_width,categoryStartY - 10,false)
draw_set_font(fn_titleLato)
draw_set_color(c_white)
draw_text(screenMidX,screenTop,"Inventory")
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