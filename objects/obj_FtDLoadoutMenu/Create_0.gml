/// @description Insert description here
// You can write your code in this editor
verticalScroll = 0
ftdInventoryElements = ds_list_create()
itemHeight = 0


function getFtDInventory() {
	for (var i = 0; i < ds_list_size(obj_inventoryController.inventoryElements); ++i) {
		var currentElement = new LoadoutElement()
		var currentInventoryElement = ds_list_find_value(obj_inventoryController.inventoryElements,i)
		if (currentInventoryElement.category == "ftd") {
			currentElement.itemName = currentInventoryElement.itemName
			currentElement.isEquipped = currentInventoryElement.isEquipped
			show_message(currentInventoryElement)
			show_message(currentInventoryElement.itemName)
			ds_list_add(ftdInventoryElements,currentElement)
		}
	}
	show_message(ds_list_size(obj_inventoryController.inventoryElements))
}

getFtDInventory()

