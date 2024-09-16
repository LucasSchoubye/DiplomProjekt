/// @description Insert description here
// You can write your code in this editor
verticalScroll = 0
storeElements = ds_list_create()
categoryElements = ds_list_create()
obj_firestore_controller.RequestStoreItems()

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


