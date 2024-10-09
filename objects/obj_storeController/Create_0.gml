/// @description Insert description here
// You can write your code in this editor
verticalScroll = 0
storeElements = ds_list_create()
categoryElements = ds_list_create()
categoryViews = [ds_list_create(),ds_list_create(),ds_list_create()]
balance = undefined
selectedPrice = 0
isOwned = false
currentCategory = Categories.All

obj_firestore_controller.RequestStoreItems("typeracer")
obj_firestore_controller.RequestStoreItems("clothes")
obj_firestore_controller.RequestBalance()


enum Categories{
	All,
	Clothes,
	Typeracer
}

ds_list_add(categoryElements, "All")
ds_list_add(categoryElements, "Clothes")
ds_list_add(categoryElements, "Typeracer")

function GetStoreData(storeData,itemID) {
	var currentElement = new StoreElement()
	currentElement.itemName = storeData[?"name"]
	currentElement.price = storeData[?"price"]
	currentElement.itemID = itemID
	currentElement.isOwned = false
	currentElement.category = storeData[?"category"]
	var last_dash_pos = string_last_pos("/", currentElement.category);
	// Check if there is a dash in the string
	if (last_dash_pos != -1) {
		// Extract the substring after the last dash
		currentElement.category = string_copy(currentElement.category, last_dash_pos + 1, string_length(currentElement.category) - last_dash_pos);
	}
	
	ds_list_add(storeElements, currentElement)
	ds_list_add(categoryViews[scr_getCategoryEnumFromString(currentElement.category)], currentElement)
	
}

function GetBalanceData(balanceData) {
	var currentBalance = new StoreElement()
	currentBalance.balance = balanceData[?"balance"]
	balance = currentBalance.balance
	
}





