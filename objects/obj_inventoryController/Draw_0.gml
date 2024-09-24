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
var	categoryTextStartX =  room_width*0.01
var	categoryCenterY = categoryHeight/2
var	categoryImgStartX = categoryWidth-30


if(room == rm_inventory) {
	if(balance != obj_storeController.balance){
		balance = obj_storeController.balance
		obj_firestore_controller.UpdateBalance()
	}
	
draw_text(screenMidX,screenTop,"Inventory")
draw_text(currencyStart,screenTop, string(balance) + "$")

for (var i = 0; i < ds_list_size(categoryElements); ++i) {
	draw_rectangle(categoryStartX,categoryStartY + i*categoryHeight,categoryStartX+categoryWidth,categoryStartY+categoryHeight+i*categoryHeight,true)
	draw_sprite(spr_theOneAndOnlySmall,0,categoryStartX+categoryImgStartX,categoryStartY+categoryCenterY + i*categoryHeight)
	draw_set_halign(fa_left)
	draw_text(categoryStartX+categoryTextStartX,categoryStartY+categoryCenterY+i*categoryHeight,ds_list_find_value(categoryElements,i))
	draw_set_halign(fa_center)
	if(mouse_x > categoryStartX && mouse_x < categoryStartX+categoryWidth) {
		if(mouse_y > categoryStartY + i*categoryHeight && mouse_y < categoryStartY+categoryHeight+ i*categoryHeight) {
			draw_set_alpha(0.3)
			draw_rectangle(categoryStartX,categoryStartY + i*categoryHeight,categoryStartX+categoryWidth,categoryStartY+categoryHeight+ i*categoryHeight,false)
			draw_set_alpha(1)
			if (mouse_check_button_pressed(mb_left)){
				currentCategory = i;
			}
		}
	}
	// Active Category
	draw_set_alpha(0.15)
	draw_rectangle(categoryStartX,categoryStartY + currentCategory*categoryHeight,categoryStartX+categoryWidth,categoryStartY+categoryHeight+ currentCategory*categoryHeight,false)
	draw_set_alpha(1)
}

scr_inventoryCategories()


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