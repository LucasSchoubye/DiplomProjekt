// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_categories(){
var screenMidX = room_width/2
var screenMidY = room_height/2
var itemStartX = room_width*0.23
var itemStartY = room_height*0.125
itemHeight = room_height*0.3
var itemCounter = 0
itemRow = 0
var itemWidth = room_width*0.15
var storeElements = obj_storeController.storeElements
var currentList = storeElements

currentList = obj_storeController.storeElements

switch(currentCategory) {
	case Categories.All:
		currentList = obj_storeController.storeElements
		break;
	case Categories.Clothes:
		currentList = obj_storeController.categoryViews[Categories.Clothes]
		break;
	case Categories.Typeracer:
		currentList = obj_storeController.categoryViews[Categories.Typeracer]
		break;
}

for (var i = 0; i < ds_list_size(currentList); ++i) {
	var currentElement = ds_list_find_value(currentList,i)
    
	
	ds_list_find_value(currentList,i).DrawItem(itemStartX+itemCounter*(itemWidth+5),itemStartY+itemRow*(itemHeight+5)+verticalScroll)
	
	
	if (mouse_check_button_pressed(mb_left) and mouse_x > itemStartX+itemCounter*itemWidth && mouse_x < itemStartX+itemCounter*itemWidth+itemWidth){
		if(mouse_y > itemStartY+itemRow*itemHeight && mouse_y < itemStartY+itemRow*itemHeight+itemHeight) {
			if(real(selectedPrice) <= real(balance) && currentElement.isOwned == false) {
				audio_play_sound(sou_purchase,1,false, 1, 0.3, 1)
				balance = balance-selectedPrice
				currentElement.isOwned = true
				var newInventoryElement = new InventoryElement() 
				newInventoryElement.itemName = currentElement.itemName
				newInventoryElement.itemID = currentElement.itemID
				newInventoryElement.category = currentElement.category
				ds_list_add(obj_inventoryController.inventoryElements, newInventoryElement)
				ds_list_add(obj_inventoryController.categoryViews[scr_getCategoryEnumFromString(currentElement.category)],newInventoryElement)
				obj_firestore_controller.UpdateStudentInventory()
				obj_firestore_controller.UpdateBalance()
			}
			else if (currentElement.isOwned == true) {
				show_message("You already own this item")
			}
			else {
				show_message("You need more $$$")
			}
		}
	}
	itemCounter++
	if (itemCounter == 4)
    {
        itemCounter = 0
        itemRow++
    }
}
}
