/// @description Insert description here
// You can write your code in this editor
verticalScroll = 0
storeElements = ds_list_create()
categoryElements = ds_list_create()
inventoryElements = ds_list_create()
balance = 100
selectedPrice = 0

obj_firestore_controller.RequestStoreItems()
obj_firestore_controller.RequestStudentInventory()



for (var i = 0; i < 5; ++i) {
	ds_list_add(categoryElements, new StoreElement())
}


function GetStoreData(storeData) {
	var currentElement = new StoreElement()
	currentElement.itemName = storeData[?"name"]
	currentElement.price = storeData[?"price"]
	
	//currentElement.itemSprite = spr_typeracerIcon
	
	
	ds_list_add(storeElements, currentElement)
}

function GetInventoryData(inventoryData) {
	var currentInventory = new StoreElement()
	currentInventory.balance = inventoryData[?"balance"]
	
	
	//currentElement.itemSprite = spr_typeracerIcon
	
	balance = currentInventory.balance
	//ds_list_add(inventoryElements, currentInventory)
}



