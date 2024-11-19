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
		case "A good default armor option for when you want a balanced build of decent speed, health and stamina":
			var array = [text, "Et godt mellem valg for når du gerne vil have en balanceret opbygning af liv, fart og udholdenhed"]
		break;
		case "Good for when you think you will have to tank a few hits to defeat the boss":
			var array = [text, "God til når du mener at du er nødt til at tanke et par slag for at besejre bossen"]
		break;
		case "If the risky dodging playstyle is your passion you can take it to its full potential with Light Armor which enhances your speed greatly but reduces the amount of hits you can take":
			var array = [text, "Hvis den risikable undvigelsesspilstil er din passion, kan du tage den til sit fulde potentiale med Let Rustning, som i høj grad øger din hastighed, men reducerer antallet af slag, du kan tåle"]
		break;
		case "A basic but good choice with a single projectile of decent damage and great range":
			var array = [text, "En simpel men god mulighed med et enkelt projektil, der har rimelig skade og fantastisk rækkevidde"]
		break;
		case "A very strong single projectile with very high damage but shorter range. So get close!":
			var array = [text, "Et meget stærkt enkeltprojektil med meget høj skade, men kortere rækkevidde. Så kom tæt på!"]
		break;
		case "A great choice against multiple foes, as the damage is split out between its multiple projectiles":
			var array = [text, "Et fremragende valg mod flere fjender, da skaden fordeles mellem dets mange projektiler"]
		break;
		case "Stats":
			var array = [text, "Statistikker"]
		break;
		case "Damage:":
			var array = [text, "Skade:"]
		break;
		case "Projectiles:":
			var array = [text, "Projektiler:"]
		break;
		case "Range:":
			var array = [text, "Rækkevidde:"]
		break;
		case "Health:":
			var array = [text, "Liv:"]
		break;
		case "Speed:":
			var array = [text, "Fart:"]
		break;
		case "Stamina:":
			var array = [text, "Udholdenhed:"]
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