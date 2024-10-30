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

function weaponEquipped() {
	switch(obj_FtDLoadoutMenu.currentWeaponEquip.itemName) {
		case "Thunderbolt": 
			bulletInst = instance_create_depth(x,y,depth,obj_playerAttack)
		break
		case "Fireball":
			bulletInst = instance_create_depth(x,y,depth,obj_FtDPlayerFireball)
			ekstraFireBall1 = instance_create_depth(x,y,depth,obj_FtDPlayerFireball) 
			ekstraFireBall2 = instance_create_depth(x,y,depth,obj_FtDPlayerFireball)
			// aim for enemy
			//if (instance_exists(obj_FtDBoss)){
			// dir = point_direction(x,y, obj_FtDBoss.x, obj_FtDBoss.y)
			//}
		break
	}
}



	