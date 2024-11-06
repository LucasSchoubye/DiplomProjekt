// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltimateManagerTranslatedTexts(text){

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

	// Find translated text
	switch(text)
	{
		#region Main Manager Menu
			case "Press club name to change":
				var array = [text, "Click på Klubnavn for at ændre"]
			break;	
		
			case "New clubname":
				var array = [text, "Nye klubnavn"]
			break;	
		
			case "Play Match":
				var array = [text, "Spil Kamp"]
			break;	
		
			case "Club name cannot exceed 20 characters":
				var array = [text, "Klubnavn skal være under 20 tegn"]
			break;	
		
			case "Change":
				var array = [text, "Skift"]
			break;	
		
			case "Cancel":
				var array = [text, "Fortryd"]
			break;	
		
			case "Home":
				var array = [text, "Oversigt"]
			break;
		
			case "Tactics":
				var array = [text, "Holdopstilling"]
			break;
		
			case "Fixtures":
				var array = [text, "Kampe"]
			break;
		
			case "Transfermarket":
				var array = [text, "Transfermarked"]
			break;
		
			case "Quit":
				var array = [text, "Afslut"]
			break;
		#endregion
		
		#region Home	
			case "Next Match - Week ":
				var array = [text, "Næste Kamp - Uge "]
			break;
			
			case "Team Stats":
				var array = [text, "Klub Stats"]
			break;
			
			case "Player Stats":
				var array = [text, "Spiller Stats"]
			break;
			
			case "Top Goalscorer":
				var array = [text, "Topscorer"]
			break;
			
			case "Most Assists":
				var array = [text, "Flest Assists"]
			break;
			
			case "Most Tackles":
				var array = [text, "Flest Tacklinger"]
			break;
			
			case "Attempted Passes":
				var array = [text, "Forsøgte Spilninger"]
			break;
			
			case "Attempted Shots":
				var array = [text, "Forsøgte Skud"]
			break;
			
			case "Most Touches":
				var array = [text, "Flest Berøringer"]
			break;
		#endregion
		
		#region	Transfermarket
			case "Balance: ":
				var array = [text, "Konto: "]
			break;
			case "SELL":
				var array = [text, "SÆLG"]
			break;
			case "Are you sure you want to sell this player for ":
				var array = [text, "Er du sikker at du vil sælge denne spiller for "]
			break;
			case "YES":
				var array = [text, "JA"]
			break;
			case "NO":
				var array = [text, "NEJ"]
			break;
			case "Get a full starting 11 of your current available pack tier to get the next tier of pack":
				var array = [text, "Få en fuld holdopstilling af dit nuværende tilgængelige pakkeniveau for at få det næste pakkeniveau"]
			break;
		#endregion
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