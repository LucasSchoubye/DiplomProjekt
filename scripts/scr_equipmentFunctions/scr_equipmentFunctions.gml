// Equipped armor create function (set health)
function armorCreate(){
	switch(obj_FtDLoadoutMenu.currentArmorEquip.itemName) {
		case "Medium Armor": 
			getDamagedCreate(,true)
		break
		case "Heavy Armor":
			getDamagedCreate(10,true)
		break
		case "Light Armor":
			getDamagedCreate(3,true)
		break
	}
}

// Equipped armor movement function (set stamina inc and dec and base movespeed)
function armorMovement() {
	switch(obj_FtDLoadoutMenu.currentArmorEquip.itemName) {
		case "Medium Armor": 
			scr_playerMovement()
			obj_FtDPlayer.staminaRestoration = 1
		break
		case "Heavy Armor":
			scr_playerMovement(5)
			obj_FtDPlayer.staminaDecrease = -1.3
		break
		case "Light Armor":
			scr_playerMovement(8)
			obj_FtDPlayer.staminaRestoration = 1
			obj_FtDPlayer.staminaDecrease = -0.5
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
		break
		case "Black Hole":
			bulletInst = instance_create_depth(x,y,depth,obj_FtDPlayerBlackHole)
		break
	}
}



	