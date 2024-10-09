/// @description Insert description here
// You can write your code in this editor
verticalScroll = 0
itemElements = ds_list_create()
categoryElements = ds_list_create()
gameNames = ds_list_create()

for (var i = 0; i < 20; ++i) {
    //ds_list_add(itemElements, new MenuGridElement())
}

for (var i = 0; i < 4; ++i) {
	var category = new MenuGridElement()
	
	switch(i)
	{
		case 0:
			category.itemName = "All Games"
		break;
		case 1:
			category.itemName = "Action Games"
		break;
		case 2:
			category.itemName = "Casual Games"
		break;
		case 3:
			category.itemName = "Hard Games"
		break;
	}
	
	ds_list_add(categoryElements, category)
}

function GetGameData(gameData) {
	var currentElement = new MenuGridElement()
	currentElement.itemName = gameData[?"name"]
	currentElement.itemSprite = spr_typeracerIcon
	ds_list_add(itemElements, currentElement)
}
