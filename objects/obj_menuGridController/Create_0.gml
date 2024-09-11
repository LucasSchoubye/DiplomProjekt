/// @description Insert description here
// You can write your code in this editor
verticalScroll = 0
itemElements = ds_list_create()
categoryElements = ds_list_create()
gameNames = ds_list_create()

for (var i = 0; i < 20; ++i) {
    //ds_list_add(itemElements, new MenuGridElement())
}

for (var i = 0; i < 5; ++i) {
	ds_list_add(categoryElements, new MenuGridElement())
}

function GetGameData(gameData) {
	var currentElement = new MenuGridElement()
	currentElement.itemName = gameData[?"name"]
	currentElement.itemSprite = spr_typeracerIcon
	

	ds_list_add(itemElements, currentElement)
	
}
