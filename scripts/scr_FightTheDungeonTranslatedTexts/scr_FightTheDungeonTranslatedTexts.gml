// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_FightTheDungeonTranslatedTexts(text){

// Get language
var languageIndex = undefined
switch (obj_languageController.languageChosen)
{
	case Languages.Danish:
		languageIndex = 1
	break;
	case Languages.English:
		languageIndex = 0
	break;
}

	// 
	switch(text)
	{
		case "Fight The Dungeon Loadout":
			var array = [text, "Vælg dit udstyr"]
		break;
		case "Fight!":
			var array = [text, "Kæmp!"]
		break;
		case "Weapon":
		case "Weapons":
			var array = [text, "Våben"]
		break;
		case "Armor":
			var array = [text, "Rustning"]
		break;
		case "Time: ":
			var array = [text, "Tid: "]
		break;
		case "EQUIPPED":
			var array = [text, "VALGT"]
		break;
		case "Back":
			var array = [text, "Tilbage"]
		break;
		case "Please fill out your equipment before starting!":
			var array = [text, "Vælg venligst dit udstyr før du starter!"]
		break;
		
		default:
			return ""
	}

	// Return
	try 
	{
		return array[languageIndex]
	}
	catch(err)
	{
		show_debug_message(err)
		return text
	}
}