/// @description Insert description here
// You can write your code in this editor
verticalArmorScroll = 0
verticalWeaponScroll = 0
ftdInventoryWeapons = ds_list_create()
ftdInventoryArmor = ds_list_create()
itemHeight = 0


function getFtDInventory() {
	for (var i = 0; i < ds_list_size(obj_inventoryController.inventoryElements); ++i) {
		var currentElement = new LoadoutElement()
		var currentInventoryElement = ds_list_find_value(obj_inventoryController.inventoryElements,i)
		if (currentInventoryElement.category == "ftd") {
			currentElement.itemID = currentInventoryElement.itemID
			currentElement.itemName = currentInventoryElement.itemName
			currentElement.isEquipped = currentInventoryElement.isEquipped
			currentElement.itemType = currentInventoryElement.itemType
		
			if (currentElement.itemType == "weapon") {
				ds_list_add(ftdInventoryWeapons,currentElement)
			} else if ( currentElement.itemType == "armor") {
				ds_list_add(ftdInventoryArmor, currentElement)
			}
		}
	}
}

getFtDInventory()

