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
			
			// 
			case "Matches Played":
				var array = [text, "Kampe Spillet"]
			break;
			case "Win Percentage":
				var array = [text, "Sejrsprocent"]
			break;
			case "Goals Scored":
				var array = [text, "Mål Scored"]
			break;
			case "Goals Conceded":
				var array = [text, "Mål indkasseret"]
			break;
			case "Yellow Cards":
				var array = [text, "Gule Kort"]
			break;
			case "Red Cards":
				var array = [text, "Røde Kort"]
			break;
			
			// League table
			case "P":
				var array = [text, "S"]
			break;
			case "W":
				var array = [text, "V"]
			break;
			case "D":
				var array = [text, "U"]
			break;
			case "L":
				var array = [text, "T"]
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
			case "This player is currently in your starting 11 and cannot be sold, please remove them from your starting 11 to be able to sell":
				var array = [text, "Denne spiller er i din startformation og kan ikke blive solgt, venligst udskift denne spiller før du sælger dem"]
			break;
			case "You do you possess the sufficient funds":
				var array = [text, "Du har ikke nok Content Coins"]
			break;
		#endregion
			
			#region Player card
			case "Age: ":
				var array = [text, "Alder: "]
			break;
			case "Position: ":
				var array = [text, "Position: "]
			break;
			case "Pac":
				var array = [text, "Hast"]
			break;
			case "Dri":
				var array = [text, "Drib"]
			break;
			case "Sho":
				var array = [text, "Skud"]
			break;
			case "Sho Str":
				var array = [text, "Sku Sty"]
			break;
			case "Pas":
				var array = [text, "Afl"]
			break;
			case "Pas Str":
				var array = [text, "Afl Sty"]
			break;
			case "Str":
				var array = [text, "Fys"]
			break;
			case "Def":
				var array = [text, "For"]
			break;
			#endregion
			
			#region Packs
			case "BUY":
				var array = [text, "KØB"]
			break;
			case "UNAVAILABLE":
				var array = [text, "IKKE TILGÆNGELIG"]
			break;
			case "Bronze Pack":
				var array = [text, "Bronze Pakke"]
			break;
			case "1 45+ Rated Player":
				var array = [text, "En 45+ Rated Spiller"]
			break;
			case "Silver Pack":
				var array = [text, "Sølv Pakke"]
			break;
			case "1 55+ Rated Player":
				var array = [text, "En 55+ Rated Spiller"]
			break;
			case "Gold Pack":
				var array = [text, "Guld Pakke"]
			break;
			case "1 65+ Rated Player":
				var array = [text, "En 65+ Rated Spiller"]
			break;
			case "Ruby Pack":
				var array = [text, "Rubin Pakke"]
			break;
			case "1 75+ Rated Player":
				var array = [text, "En 75+ Rated Spiller"]
			break;
			case "Obsidian Pack":
				var array = [text, "Obsidian Pakke"]
			break;
			case "1 85+ Rated Player":
				var array = [text, "En 85+ Rated Spiller"]
			break;
			case "Legendary Pack":
				var array = [text, "Legendarisk Pakke"]
			break;
			case "1 95+ Rated Player":
				var array = [text, "En 95+ Rated Spiller"]
			break;
		#endregion
		
		#region Tactics
			case "ST":
				var array = [text, "ANG"]
			break;
			case "RW":
				var array = [text, "HF"]
			break;
			case "LW":
				var array = [text, "LF"]
			break;
			case "RM":
				var array = [text, "HM"]
			break;
			case "LM":
				var array = [text, "VM"]
			break;
			case "CM":
				var array = [text, "CM"]
			break;
			case "CAM":
				var array = [text, "COM"]
			break;
			case "CDM":
				var array = [text, "CDM"]
			break;
			case "CB":
				var array = [text, "CB"]
			break;
			case "LB":
				var array = [text, "VB"]
			break;
			case "RB":
				var array = [text, "HB"]
			break;
			case "LWB":
				var array = [text, "VFB"]
			break;
			case "RWB":
				var array = [text, "HFB"]
			break;
			case "GK":
				var array = [text, "MM"]
			break;
			case "SUB":
				var array = [text, "UDS"]
			break;
		#endregion
		
		/*
		switch(drawnPosition)
		{
			case FootballPositions.ST:
				return "ST"
			case FootballPositions.RW:
				return "RW"
			case FootballPositions.LW:
				return "LW"
			case FootballPositions.RM:
				return "RM"
			case FootballPositions.LM:
				return "LM"
			case FootballPositions.CM:
				return "CM"
			case FootballPositions.CAM:
				return "CAM"
			case FootballPositions.CDM:
				return "CDM"
			case FootballPositions.CB:
				return "CB"
			case FootballPositions.LB:
				return "LB"
			case FootballPositions.RB:
				return "RB"
			case FootballPositions.RWB:
				return "RWB"
			case FootballPositions.LWB:
				return "LWB"
			case FootballPositions.GK:
				return "GK"
			case FootballPositions.SUB:
				return "SUB"
				
		}
		*/
		
		#region In-Match
			case "Match Completed!":
				var array = [text, "Kamp Færdigspillet!"]
			break;
			case "Halftime: ":
				var array = [text, "Halvleg: "]
			break;
			case "Total Reward: ":
				var array = [text, "Samlet Gevinst: "]
			break;
			case "Get Reward":
				var array = [text, "Få Gevinst"]
			break;
			case "Match won: +":
				var array = [text, "Kamp Vundet: +"]
			break;
			case "Match lost: +":
				var array = [text, "Kamp Tabt: +"]
			break;
			case "Match drawn: +":
				var array = [text, "Kamp Uafgjort: +"]
			break;
			case "Clean Sheet: +":
				var array = [text, "Rent Bur: +"]
			break;
			case "Goal Bonus X":
				var array = [text, "Mål Bonus X"]
			break;
			case "Play next half":
				var array = [text, "Spil næste Halvleg"]
			break;
			case "Drag Right Click: Make teammate move":
				var array = [text, "Træk med Højre-klik: Flyt dine medspillere"]
			break;
			case "Left Click: Move Player":
				var array = [text, "Venstre Klik: Flyt din spiller"]
			break;
			case "Hold Shift: Shoot/Pass":
				var array = [text, "Hold Shift: for at skyde eller spille"]
			break;
			case "Drag with right mouse button":
				var array = [text, "Træk med højre-klik på musen"]
			break;
			case "Shot difficulty: ":
				var array = [text, "Sværhedsgrad på skud: "]
			break;
			case " questions!":
				var array = [text, " spørgsmål!"]
			break;
			case " left)":
				var array = [text, " tilbage)"]
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