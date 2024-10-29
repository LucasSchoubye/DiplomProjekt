// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_loadoutInventory(){

// GENERAL VARIABLES
var itemHeight = room_height*0.15
var itemWidth = room_width*0.075
var screenTop = 50
var defaultFont = draw_get_font()
var screenMidX = room_width/2
var screenMidY = room_height/2
var inventoryList = obj_inventoryController.inventoryElements
var activeInventoryElement = undefined

// WEAPONS
// WEAPON VARIABLES
var weaponStartX = room_width*0.05
var weaponStartY = room_height*0.18
var weaponCounter = 0
weaponRow = 0
var ftdInventoryWeapons = obj_FtDLoadoutMenu.ftdInventoryWeapons
var currentWeaponList = ftdInventoryWeapons
var currentWeaponEquip = ds_list_create()



//draw weapon collection rectancle and title
draw_set_halign(fa_left)
draw_set_font(fn_TwCenMTCondensed)
draw_text(weaponStartX+5,weaponStartY-20,"Weapons")
draw_roundrect(weaponStartX,weaponStartY,weaponStartX+5*itemWidth,weaponStartY+2*itemHeight,true)
//reset values
draw_set_halign(fa_center)
draw_set_font(defaultFont)

for (var i = 0; i < ds_list_size(currentWeaponList); ++i) {
	var currentWeaponElement = ds_list_find_value(currentWeaponList,i)
	
	// make sure that it is the overall inventory item that is the one being updated in regards to wether it is equipped
	for (var z = 0; z < ds_list_size(inventoryList); ++z) {
		var currentInventoryElement = ds_list_find_value(inventoryList,z)
		if (currentWeaponElement.itemName == currentInventoryElement.itemName) {
			activeInventoryElement = currentInventoryElement
		}
	}
	
    currentWeaponElement.DrawFtDItem(weaponStartX+weaponCounter*itemWidth,weaponStartY+weaponRow*itemHeight+verticalWeaponScroll)
	if (mouse_check_button_pressed(mb_left) and mouse_x > weaponStartX+weaponCounter*itemWidth && mouse_x < weaponStartX+weaponCounter*itemWidth+itemWidth){
		if(mouse_y > weaponStartY+weaponRow*itemHeight && 
			mouse_y < weaponStartY+weaponRow*itemHeight+itemHeight) {
			
			ds_list_clear(currentWeaponEquip)
			// update both the local version (for the text) and the database inventory item on wether it is equipped
			if (activeInventoryElement.isEquipped == false) 
			{
				// Unequip all other weapons before equipping new one
				for (var z = 0; z < ds_list_size(inventoryList); ++z) {
					var currentInventoryElement = ds_list_find_value(inventoryList,z)
					if (currentInventoryElement.isEquipped == true && currentInventoryElement.itemType == "weapon") {
						currentInventoryElement.isEquipped = false
						obj_firestore_controller.UpdateInventory(currentInventoryElement)
					}
				}
				for (var z = 0; z < ds_list_size(currentWeaponList); ++z) {
					var allActiveEquips = ds_list_find_value(currentWeaponList,z)
					if (allActiveEquips.isEquipped == true) {
						allActiveEquips.isEquipped = false
					}
				}
				
				activeInventoryElement.isEquipped = true
				currentWeaponElement.isEquipped = true
				ds_list_add(currentWeaponEquip,currentWeaponElement)
			} 
			else 
			{
				activeInventoryElement.isEquipped = false
				currentWeaponElement.isEquipped = false
			}
			obj_firestore_controller.UpdateInventory(activeInventoryElement)
		}
	}
	weaponCounter++
	if (weaponCounter == 5)
    {
        weaponCounter = 0
        weaponRow++
    }
}
	

// ARMOR
// ARMOR VARIABLES
var armorStartX = room_width*0.05
var armorStartY = weaponStartY+2*itemHeight+50
var armorCounter = 0
armorRow = 0
var ftdInventoryArmor = obj_FtDLoadoutMenu.ftdInventoryArmor
var currentArmorList = ftdInventoryArmor
var currentArmorEquip = ds_list_create()


//draw armor collection rectancle and title
draw_set_halign(fa_left)
draw_set_font(fn_TwCenMTCondensed)
draw_text(armorStartX+5,armorStartY-20,"Armor")
draw_roundrect(armorStartX,armorStartY,armorStartX+5*itemWidth,armorStartY+2*itemHeight,true)
//reset values
draw_set_halign(fa_center)
draw_set_font(defaultFont)



for (var i = 0; i < ds_list_size(currentArmorList); ++i) {
	var currentArmorElement = ds_list_find_value(currentArmorList,i)

	// make sure that it is the overall inventory item that is the one being updated in regards to wether it is equipped
	for (var z = 0; z < ds_list_size(inventoryList); ++z) {
		var currentInventoryElement = ds_list_find_value(inventoryList,z)
		if (currentArmorElement.itemName == currentInventoryElement.itemName) {
			activeInventoryElement = currentInventoryElement
		}
	}

	currentArmorElement.DrawFtDItem(armorStartX+armorCounter*itemWidth,armorStartY+armorRow*itemHeight+verticalArmorScroll)
	if (mouse_check_button_pressed(mb_left) and mouse_x > armorStartX+armorCounter*itemWidth && mouse_x < armorStartX+armorCounter*itemWidth+itemWidth){
		if(mouse_y > armorStartY+armorRow*itemHeight && 
			mouse_y < armorStartY+armorRow*itemHeight+itemHeight) {
				
			ds_list_clear(currentArmorEquip)
			// update both the local version (for the text) and the database inventory item on wether it is equipped
			if (activeInventoryElement.isEquipped == false) 
			{
				// Unequip all other weapons before equipping new one
				for (var z = 0; z < ds_list_size(inventoryList); ++z) {
					var currentInventoryElement = ds_list_find_value(inventoryList,z)
					if (currentInventoryElement.isEquipped == true && currentInventoryElement.itemType == "armor") {
						currentInventoryElement.isEquipped = false
						obj_firestore_controller.UpdateInventory(currentInventoryElement)
					}
				}
				for (var z = 0; z < ds_list_size(currentArmorList); ++z) {
					var allActiveArmorEquips = ds_list_find_value(currentArmorList,z)
					if (allActiveArmorEquips.isEquipped == true) {
						allActiveArmorEquips.isEquipped = false
					}
				}
				
				activeInventoryElement.isEquipped = true
				currentArmorElement.isEquipped = true
				ds_list_add(currentArmorEquip,currentArmorElement)
			} 
			else 
			{
				activeInventoryElement.isEquipped = false
				currentArmorElement.isEquipped = false
			}
			obj_firestore_controller.UpdateInventory(activeInventoryElement)
		}
	}
	armorCounter++
	if (armorCounter == 5) {
		armorCounter = 0
	    armorRow++
	}
}


// DRAW INVENTORY SLOTS
// VARIABLES
var weaponEquipStartX = room_width*0.65
var weaponEquipStartY = room_height*0.8
var armorEquipStartX = weaponEquipStartX + itemWidth + 20
var armorEquipStartY = weaponEquipStartY



// weapon equip
draw_set_alpha(0.1)
draw_set_color(c_white)
draw_roundrect_color(weaponEquipStartX,weaponEquipStartY,weaponEquipStartX+itemWidth,weaponEquipStartY+itemHeight,c_black,c_white,true)
draw_set_alpha(0.3 + sin(current_time/500)*0.1)	
draw_roundrect(weaponEquipStartX,weaponEquipStartY,weaponEquipStartX+itemWidth,weaponEquipStartY+itemHeight,true)
draw_set_alpha(1)
for (var i = 0; i < ds_list_size(currentWeaponEquip); ++i) {
	var currentWeaponEquipped = ds_list_find_value(currentWeaponEquip,i)
	show_message(currentWeaponEquipped)
	currentWeaponEquipped.DrawFtDEquipped(weaponEquipStartX,weaponEquipStartY)
}


// armor equip
draw_set_alpha(0.1)
draw_set_color(c_white)
draw_roundrect_color(armorEquipStartX,armorEquipStartY,armorEquipStartX+itemWidth,armorEquipStartY+itemHeight,c_black,c_white,true)
draw_set_alpha(0.3 + sin(current_time/500)*0.1)	
draw_roundrect(armorEquipStartX,armorEquipStartY,armorEquipStartX+itemWidth,armorEquipStartY+itemHeight,true)
draw_set_alpha(1)
for (var i = 0; i < ds_list_size(currentArmorEquip); ++i) {
	var currentArmorEquipped = ds_list_find_value(currentArmorEquip,i)
	show_message(currentArmorEquipped)
	currentArmorEquipped.DrawFtDEquipped(armorEquipStartX,armorEquipStartY)
}



draw_triangle_color(screenMidX+100,screenMidY-50,screenMidX+100,screenMidY-10,screenMidX+70,screenMidY-30,c_olive,c_olive,c_olive,false)
draw_triangle_color(screenMidX+530,screenMidY-50,screenMidX+530,screenMidY-10,screenMidX+560,screenMidY-30,c_olive,c_olive,c_olive,false)

}