/// @description Insert description here
// You can write your code in this editor
verticalScroll = 0
storeElements = ds_list_create()
categoryElements = ds_list_create()
inventoryElements = ds_list_create()
balance = undefined
selectedPrice = 0
isOwned = false

obj_firestore_controller.RequestStoreItems()
obj_firestore_controller.RequestBalance()



for (var i = 0; i < 5; ++i) {
	ds_list_add(categoryElements, new StoreElement())
}


function GetStoreData(storeData,itemID) {
	var currentElement = new StoreElement()
	currentElement.itemName = storeData[?"name"]
	currentElement.price = storeData[?"price"]
	currentElement.itemID = itemID
	currentElement.isOwned = false
	ds_list_add(storeElements, currentElement)
}

function GetBalanceData(balanceData) {
	var currentBalance = new StoreElement()
	currentBalance.balance = balanceData[?"balance"]
	
	balance = currentBalance.balance
}



