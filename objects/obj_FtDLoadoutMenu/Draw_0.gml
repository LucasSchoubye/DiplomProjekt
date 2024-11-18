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
var itemHeight = room_height*0.15
var itemWidth = room_width*0.075

var playButtonStartX = screenMidX-70
var playButtonEndX = screenMidX+70
var playButtonStartY = room_height*0.97
var playButtonEndY = room_height*0.88

var weaponStartX = room_width*0.05
var weaponStartY = room_height*0.18
	
var armorStartX = room_width*0.05
var armorStartY = weaponStartY+2*itemHeight+50

var LC = obj_languageController

if(room == rm_FtDLoadoutMenu) {
	
scr_loadoutInventory()

draw_set_color(#191115)
draw_rectangle(0,0,room_width,categoryStartY - 10,false)
draw_set_font(fn_titleLato)
draw_set_color(c_white)
draw_text(screenMidX,screenTop, LC.translate("Fight The Dungeon Loadout"))
draw_set_font(fn_textLato)
draw_text(screenMidX, screenTop+35, LC.translate(fillEquipmentTXT))
obj_characterController.DrawCharacterMenu(room_width*0.73,room_height*0.5,4)

// play button
draw_roundrect(playButtonStartX,playButtonStartY,playButtonEndX,playButtonEndY,true)
draw_text((playButtonStartX + playButtonEndX)/2,(playButtonStartY+playButtonEndY)/2,LC.translate("Fight!"))
if(mouse_x > playButtonStartX && mouse_x < playButtonEndX) {
	if(mouse_y < playButtonStartY && mouse_y > playButtonEndY) {
		draw_set_alpha(0.3)
		draw_roundrect(playButtonStartX,playButtonStartY,playButtonEndX,playButtonEndY,false)
		draw_set_alpha(1)
		if (mouse_check_button_pressed(mb_left)){
			if (currentArmorEquip == undefined || currentWeaponEquip == undefined) {
				fillEquipmentTXT = "Please fill out your equipment before starting!"
			} else {
				room_goto(rm_FtD)
			}
		}
	}
}

if(keyboard_check(vk_backspace)) {
	room_goto(rm_menu)
}

// Back button
draw_rectangle(categoryStartX,backButtonStartY,categoryStartX + backButtonWidth,backButtonStartY + backButtonHeight,true)
draw_text(categoryStartX + backButtonWidth/2,backButtonStartY+backButtonHeight/2,LC.translate("Back"))
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


// scroll weapon
if (mouse_x > weaponStartX && mouse_x < weaponStartX+5*itemWidth){
	if(mouse_y > weaponStartY && mouse_y < weaponStartY+2*itemHeight) {
		if((mouse_wheel_down()) && verticalWeaponScroll >= -armorRow*itemHeight) {
			verticalWeaponScroll -= 15
		}
		else if((mouse_wheel_up()) && verticalWeaponScroll < 0) 
		{
			verticalWeaponScroll += 15
		}
	}
}

// scroll armor
if (mouse_x > armorStartX && mouse_x < armorStartX+5*itemWidth){
	if(mouse_y > armorStartY && mouse_y < armorStartY+2*itemHeight) {
		if((mouse_wheel_down()) && verticalArmorScroll >= -armorRow*itemHeight) {
			verticalArmorScroll -= 15
		}
		else if((mouse_wheel_up()) && verticalArmorScroll < 0) 
		{
			verticalArmorScroll += 15
		}
	}
}

}