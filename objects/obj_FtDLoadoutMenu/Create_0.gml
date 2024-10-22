/// @description Insert description here
// You can write your code in this editor
verticalScroll = 0
inventoryElements = ds_list_create()
itemHeight = 0



obj_firestore_controller.RequestFtDInventory()


function GetFtDInventoryData(ftdInventoryData) {
	var currentElement = new LoadoutElement()
	var isEquipped = bool(ftdInventoryData[?"equipped"])
	var substring = ftdInventoryData[?"shopItemRef"]
	var equipmentType = ftdInventoryData[?"type"]
	var last_dash_pos = string_last_pos("/", substring);
    currentElement.isEquipped = false
	// Check if there is a dash in the string
	if (last_dash_pos != -1) {
		// Extract the substring after the last dash
		substring = string_copy(substring, last_dash_pos + 1, string_length(substring) - last_dash_pos);
	}
	

	for (var i = 0; i < ds_list_size(obj_storeController.storeElements); ++i) {
		var currentStoreElement = ds_list_find_value(obj_storeController.storeElements,i)
		if (currentStoreElement.itemID == substring) {
			currentElement.itemName = currentStoreElement.itemName
			currentStoreElement.isOwned = true
			currentElement.itemID = currentStoreElement.itemID
			currentElement.isEquipped = isEquipped
			ds_list_add(inventoryElements, currentElement)
			
		
		}
	}
}

