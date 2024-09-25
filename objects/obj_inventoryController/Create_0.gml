/// @description Insert description here
// You can write your code in this editor
verticalScroll = 0
inventoryElements = ds_list_create()
categoryElements = ds_list_create()
categoryViews = [ds_list_create(),ds_list_create(),ds_list_create()]
balance = undefined
currentCategory = Categories.All

obj_firestore_controller.RequestBalance()
obj_firestore_controller.RequestStudentInventory()

ds_list_add(categoryElements, "All")
ds_list_add(categoryElements, "Clothes")
ds_list_add(categoryElements, "Typeracer")


function GetInventoryData(inventoryData) {
	var currentElement = new InventoryElement()
	var substring = inventoryData[?"shopItemRef"]
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
			currentElement.category = currentStoreElement.category
			//show_message(currentElement.category)
			ds_list_add(inventoryElements, currentElement)
			ds_list_add(categoryViews[scr_getCategoryEnumFromString(currentElement.category)], currentElement)
		}
		
	}
}

function GetBalanceData(balanceData) {
	var currentBalance = new StoreElement()
	currentBalance.balance = balanceData[?"balance"]
	balance = currentBalance.balance
}