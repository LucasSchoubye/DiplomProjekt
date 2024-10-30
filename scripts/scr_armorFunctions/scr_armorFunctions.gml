// Equipped armor create function
function armorCreate(){
	switch(obj_FtDLoadoutMenu.currentArmorEquip.itemName) {
		case "Leather Armor": 
			getDamagedCreate(,true)
		break
		case "Diamond Armor":
			getDamagedCreate(10,true)
		break
	}
}

// Equipped armor movement function
function armorMovement() {
	switch(obj_FtDLoadoutMenu.currentArmorEquip.itemName) {
		case "Leather Armor": 
			scr_playerMovement()
		break
		case "Diamond Armor":
			scr_playerMovement(3)
		break
	}
}



	