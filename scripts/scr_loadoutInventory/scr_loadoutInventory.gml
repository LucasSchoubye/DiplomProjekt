// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_loadoutInventory(){

var LC = obj_languageController

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
currentWeaponEquip = undefined



//draw weapon collection rectancle and title
draw_set_halign(fa_left)
draw_set_font(fn_TwCenMTCondensed)
draw_text(weaponStartX+5,weaponStartY-20,LC.translate("Weapons"))
draw_roundrect(weaponStartX,weaponStartY,weaponStartX+5*itemWidth,weaponStartY+2*itemHeight,true)
//reset values
draw_set_halign(fa_center)
draw_set_font(defaultFont)

for (var i = 0; i < ds_list_size(currentWeaponList); ++i) {
	var currentWeaponElement = ds_list_find_value(currentWeaponList,i)
	
	if (currentWeaponElement.isEquipped == true) {
		currentWeaponEquip = currentWeaponElement
	}
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
				currentWeaponEquip = currentWeaponElement
			} 
			else 
			{
				activeInventoryElement.isEquipped = false
				currentWeaponElement.isEquipped = false
				currentWeaponEquip = undefined
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
currentArmorEquip = undefined


//draw armor collection rectancle and title
draw_set_halign(fa_left)
draw_set_font(fn_TwCenMTCondensed)
draw_text(armorStartX+5,armorStartY-20,LC.translate("Armor"))
draw_roundrect(armorStartX,armorStartY,armorStartX+5*itemWidth,armorStartY+2*itemHeight,true)
//reset values
draw_set_halign(fa_center)
draw_set_font(defaultFont)



for (var i = 0; i < ds_list_size(currentArmorList); ++i) {
	var currentArmorElement = ds_list_find_value(currentArmorList,i)

	if (currentArmorElement.isEquipped == true) {
		currentArmorEquip = currentArmorElement	
	}
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
				currentArmorEquip = currentArmorElement
			} 
			else 
			{
				activeInventoryElement.isEquipped = false
				currentArmorElement.isEquipped = false
				currentArmorEquip = undefined
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
var weaponEquipStartX = room_width*0.565
var weaponEquipStartY = room_height*0.8
var weaponEquipTextStartX = weaponEquipStartX + itemWidth/2
var weaponEquipTextStartY = weaponEquipStartY+itemHeight+20
var weaponDescriptionStartX = room_width*0.49
var weaponDescriptionWidth = weaponDescriptionStartX+room_width*0.23
var weaponDescriptionStartY = room_height*0.18
var weaponDescriptionHeight = weaponDescriptionStartY+room_height*0.6
var weaponDescriptionMidX = weaponDescriptionStartX+((room_width*0.23)/2)
var weaponDescriptionTextStartY = weaponDescriptionStartY+40
var weaponDescriptionStatTextStartY = weaponDescriptionStartY+room_height*0.3
var currentWeaponName = ""
var damageStat = 0
var projectileStat = 0
var rangeStat = 0
var weaponDescription = ""

var armorEquipStartX = weaponEquipStartX + itemWidth + 225
var armorEquipStartY = weaponEquipStartY
var armorEquipTextStartX = armorEquipStartX + itemWidth/2
var armorEquipTextStartY = armorEquipStartY+itemHeight+20
var armorDescriptionStartX = weaponDescriptionWidth+room_width*0.01
var armorDescriptionWidth = armorDescriptionStartX+room_width*0.23
var armorDescriptionStartY = weaponDescriptionStartY
var armorDescriptionHeight = weaponDescriptionHeight
var armorDescriptionMidX = armorDescriptionStartX+((room_width*0.23)/2)
var armorDescriptionTextStartY = armorDescriptionStartY+40
var armorDescriptionStatTextStartY = armorDescriptionStartY+room_height*0.3
var currentArmorName = ""
var healthStat = 0
var speedStat = 0
var staminaStat = 0
var armorDescription = ""


// weapon equip
draw_set_alpha(0.1)
draw_set_color(c_white)
draw_roundrect_color(weaponEquipStartX,weaponEquipStartY,weaponEquipStartX+itemWidth,weaponEquipStartY+itemHeight,c_black,c_white,true)
draw_set_alpha(0.3 + sin(current_time/500)*0.1)	
draw_roundrect(weaponEquipStartX,weaponEquipStartY,weaponEquipStartX+itemWidth,weaponEquipStartY+itemHeight,true)
draw_set_alpha(1)
draw_set_font(fn_TwCenMTCondensed)
draw_text(weaponEquipTextStartX,weaponEquipTextStartY,LC.translate("Weapon"))
draw_set_font(defaultFont)
if (currentWeaponEquip != undefined) {
	currentWeaponEquip.DrawFtDEquipped(weaponEquipStartX,weaponEquipStartY)
}


// Switch for what weapon stats are shown
if (currentWeaponEquip != undefined){
	switch(currentWeaponEquip.itemName) {
		case "Thunderbolt": 
			currentWeaponName = currentWeaponEquip.itemName
			damageStat = 6
			projectileStat = 1
			rangeStat = 10
		break
		case "Black Hole":
			currentWeaponName = currentWeaponEquip.itemName
			damageStat = 10
			projectileStat = 1
			rangeStat = 5
		break
		case "Fireball":
			currentWeaponName = currentWeaponEquip.itemName
			damageStat = 3
			projectileStat = 3
			rangeStat = 10
		break
	}
} else {
	currentWeaponName = "No Weapon Equipped"
	damageStat = 0
	projectileStat = 0
	rangeStat = 0
}


// Weapon equipped description
draw_roundrect(weaponDescriptionStartX,weaponDescriptionStartY,weaponDescriptionWidth,weaponDescriptionHeight,true)
draw_set_font(fn_TwCenMTCondensed)
draw_text(weaponDescriptionMidX,weaponDescriptionStartY+20,string(currentWeaponName))
draw_text(weaponDescriptionMidX,weaponDescriptionStatTextStartY+60,"Stats")
draw_set_halign(fa_left)
draw_text(weaponDescriptionStartX+10,weaponDescriptionStatTextStartY+100,"Damage:")
draw_sprite(spr_stat10,damageStat,weaponDescriptionStartX+120,weaponDescriptionStatTextStartY+100)
draw_text(weaponDescriptionStartX+10,weaponDescriptionStatTextStartY+150,"Projectiles:")
draw_sprite(spr_stat3,projectileStat,weaponDescriptionStartX+120,weaponDescriptionStatTextStartY+150)
draw_text(weaponDescriptionStartX+10,weaponDescriptionStatTextStartY+200,"Range:")
draw_sprite(spr_stat10,rangeStat,weaponDescriptionStartX+120,weaponDescriptionStatTextStartY+200)
draw_set_font(defaultFont)
draw_text(weaponDescriptionStartX+10,weaponDescriptionTextStartY+20,string(weaponDescription))
draw_set_halign(fa_center)



// armor equip
draw_set_alpha(0.1)
draw_set_color(c_white)
draw_roundrect_color(armorEquipStartX,armorEquipStartY,armorEquipStartX+itemWidth,armorEquipStartY+itemHeight,c_black,c_white,true)
draw_set_alpha(0.3 + sin(current_time/500)*0.1)	
draw_roundrect(armorEquipStartX,armorEquipStartY,armorEquipStartX+itemWidth,armorEquipStartY+itemHeight,true)
draw_set_alpha(1)
draw_set_font(fn_TwCenMTCondensed)
draw_text(armorEquipTextStartX,armorEquipTextStartY,LC.translate("Armor"))
draw_set_font(defaultFont)
if (currentArmorEquip != undefined) {
	currentArmorEquip.DrawFtDEquipped(armorEquipStartX,armorEquipStartY)
}


// Switch for what armor stats are shown
if (currentArmorEquip != undefined){
	switch(currentArmorEquip.itemName) {
		case "Medium Armor": 
			currentArmorName = currentArmorEquip.itemName
			healthStat = 5
			speedStat = 6
			staminaStat = 5
			armorDescription = "A good default armor option for when you want a balanced build of decent speed, health and stamina"
		break
		case "Heavy Armor":
			currentArmorName = currentArmorEquip.itemName
			healthStat = 10
			speedStat = 3
			staminaStat = 3
			armorDescription = "Good for when you think you can kill the boss in time by tanking a few hits"
		break
		case "Light Armor":
			currentArmorName = currentArmorEquip.itemName
			healthStat = 3
			speedStat = 9
			staminaStat = 10
			armorDescription = "If the risky dodging playstyle is your passion you can take it to its full potential with Light Armor which enhances your speed greatly but reduces the amount of hits you can take"
		break
	}
} else {
	currentArmorName = "No Armor Equipped"
	healthStat = 0
	speedStat = 0
	staminaStat = 0
}

// Armor equipped description
draw_roundrect(armorDescriptionStartX,armorDescriptionStartY,armorDescriptionWidth,armorDescriptionHeight,true)
draw_set_font(fn_TwCenMTCondensed)
draw_text(armorDescriptionMidX,armorDescriptionStartY+20,string(currentArmorName))
draw_text(armorDescriptionMidX,armorDescriptionStatTextStartY+60,"Stats")
draw_set_halign(fa_left)
draw_text(armorDescriptionStartX+10,armorDescriptionStatTextStartY+100,"Health:")
draw_sprite(spr_stat10,healthStat,armorDescriptionStartX+120,armorDescriptionStatTextStartY+100)
draw_text(armorDescriptionStartX+10,armorDescriptionStatTextStartY+150,"Speed:")
draw_sprite(spr_stat10,speedStat,armorDescriptionStartX+120,armorDescriptionStatTextStartY+150)
draw_text(armorDescriptionStartX+10,armorDescriptionStatTextStartY+200,"Stamina:")
draw_sprite(spr_stat10,staminaStat,armorDescriptionStartX+120,armorDescriptionStatTextStartY+200)
draw_set_font(defaultFont)
draw_text(armorDescriptionStartX+15,armorDescriptionTextStartY+30,string(armorDescription))
draw_set_halign(fa_center)




}