// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_inventoryCategories(){
var screenTop = 50
var screenMidX = room_width/2
var screenMidY = room_height/2
var itemStartX = room_width*0.23
var itemStartY = room_height*0.125
itemHeight = room_height*0.3
var itemCounter = 0
itemRow = 0
var itemWidth = room_width*0.15
var inventoryElements = obj_inventoryController.inventoryElements
var currentList = inventoryElements


currentList = obj_inventoryController.inventoryElements


switch(currentCategory) {
	case Categories.All:
		currentList = obj_inventoryController.inventoryElements
		break;
	case Categories.Clothes:
		currentList = obj_inventoryController.categoryViews[Categories.Clothes]
		break;
	case Categories.Typeracer:
		currentList = obj_inventoryController.categoryViews[Categories.Typeracer]
		break;
}

for (var i = 0; i < ds_list_size(currentList); ++i) {
	var currentElement = ds_list_find_value(currentList,i)
    ds_list_find_value(currentList,i).DrawItem(itemStartX+itemCounter*itemWidth,itemStartY+itemRow*itemHeight+verticalScroll)
	if (mouse_check_button_pressed(mb_left) and mouse_x > itemStartX+itemCounter*itemWidth && mouse_x < itemStartX+itemCounter*itemWidth+itemWidth){
		if(mouse_y > itemStartY+itemRow*itemHeight && 
			mouse_y < itemStartY+itemRow*itemHeight+itemHeight) {
			if (currentElement.isEquipped == false) 
			{
				currentElement.isEquipped = true
			} 
			else 
			{
				currentElement.isEquipped = false
			}
			obj_firestore_controller.UpdateInventory(currentElement)
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