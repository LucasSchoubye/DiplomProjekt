/// @description Setup Menu and variables
enum ultManMenus{
	Home,
	Tactics,
	Fixtures,
	Transfermarket,
	Quit
}

enum FootballPositions 
{
	GK,
	CB,
	LB,
	RB,
	LWB,
	RWB,
	CM,
	CDM,
	CAM,
	LM,
	RM,
	LW,
	RW,
	ST,
	SUB
}

enum FormationColumns
{
	Attackers, 
	OffensiveMidfield,
	Midfield,
	DefensiveMidfielder,
	Defense,
	Goalkeeper
}

teamList = ds_list_create()

// Variables

playerClub = new UltManTeam()

clubName = playerClub.clubName

menuOptions = ds_list_create()
selectedMenuOption = 0
currentMenu = ultManMenus.Home

// Determine if a user wants to sell a player
showSellPopup = false; 
// If the user is trying to sell a player in the active team
showCannotSellPopup = false
// If the user is trying to buy a pack but they meet insufficient requirements
showPopupCannotBuyPack = false
// If the user tries to buy a pack they cannot afford
showPopupCannotAffordPack = false
// Transfermarket Player Scroll
transfermarketPlayerScroll = 0
// Tactics Player Scroll
tacticsPlayerScroll = 0

// Populate menu options
ds_list_add(menuOptions, "Home")
ds_list_add(menuOptions, "Tactics")
ds_list_add(menuOptions, "Fixtures")
ds_list_add(menuOptions, "Transfermarket")
ds_list_add(menuOptions, "Quit")

// TacticsLogic
fromPlayer = undefined
fieldViewFromPlayer = undefined
toColumn = undefined

// Gameplay
teamformation = TeamFormations.FourFourTwo
formationColumns = [ds_list_create(), ds_list_create(), ds_list_create(), ds_list_create(), ds_list_create(), ds_list_create()]
squad = ds_list_create()

// Generate team from server
obj_firestore_controller.RequestGamestate("ultimateManager")

packs = ds_list_create();
ds_list_add(packs, new UltManPack(UltManPackTier.Bronze));
ds_list_add(packs, new UltManPack(UltManPackTier.Silver));
ds_list_add(packs, new UltManPack(UltManPackTier.Gold));
ds_list_add(packs, new UltManPack(UltManPackTier.Ruby));
ds_list_add(packs, new UltManPack(UltManPackTier.Obsidian));
ds_list_add(packs, new UltManPack(UltManPackTier.Legendary)); 
  
#region Gamelogic functions

function SimulateLeague()
{
	var matchups = []
	var clubsAvailable = ds_list_create()
	ds_list_copy(clubsAvailable, teamList)
	
	// Generate Matchups
	for (var i = 0; 1 < ds_list_size(clubsAvailable); ++i) 
	{
		// Home Club
		var clubId = irandom_range(0, ds_list_size(clubsAvailable)-1)
		var homeClub = ds_list_find_value(clubsAvailable, clubId)
		ds_list_delete(clubsAvailable, clubId)
		
		// Away Club
		var clubId = irandom_range(0, ds_list_size(clubsAvailable)-1)
		var awayClub = ds_list_find_value(clubsAvailable, clubId)
		ds_list_delete(clubsAvailable, clubId)
		
		if (homeClub != playerClub and awayClub != playerClub)
			matchups[i] = [homeClub, awayClub]

	}
	
	// Generate results
	for (var i = 0; i < array_length(matchups); ++i) {
	    
		// point system
		var MatchXG = [0,0]
		
		// Simulate results
		var possessionRatio = (matchups[i][0].ballPossesion + matchups[i][0].midfielderQuality*2)/(matchups[i][1].ballPossesion + matchups[i][0].midfielderQuality*2)
		
		if (possessionRatio > 1)
		{
			var dominantTeamIndex = 0
			var dominantTeam = matchups[i][0]
			var submissiveTeam = matchups[i][1]
		}
		else
		{
			var dominantTeamIndex = 1
			var dominantTeam = matchups[i][1]
			var submissiveTeam = matchups[i][0]
		}
		
		// Dominant team
		var chancesCreated = 8 + (possessionRatio-1)*10
		var chanceQuality = matchups[i][0].attackerQuality/(matchups[i][1].defenderQuality*2 + matchups[i][1].goalKeeperQuality)/3
		MatchXG[dominantTeamIndex] = chancesCreated*chanceQuality
		
		// Submissive team
		var chancesCreated = 3 + dominantTeam.counterAttacks
		var chanceQuality = matchups[i][0].attackerQuality/(matchups[i][1].defenderQuality*2 + matchups[i][1].goalKeeperQuality)/3
		MatchXG[!dominantTeamIndex] = chancesCreated*chanceQuality
		
		if (abs(MatchXG[dominantTeamIndex] - MatchXG[!dominantTeamIndex]) < MatchXG[dominantTeamIndex]*0.3)
		{
			matchups[i][0].matchesDrawn++
			matchups[i][1].matchesDrawn++
			matchups[i][0].matchesPlayed++
			matchups[i][1].matchesPlayed++
		}
		else
		{
			if (MatchXG[dominantTeamIndex] > MatchXG[!dominantTeamIndex])
			{
				dominantTeam.matchesPlayed++
				submissiveTeam.matchesPlayed++
				dominantTeam.matchesWon++
				submissiveTeam.matchesLost++
			}
			else
			{
				submissiveTeam.matchesPlayed++
				dominantTeam.matchesPlayed++
				submissiveTeam.matchesWon++
				dominantTeam.matchesLost++
			}
		}
	}
	
	show_message(json_stringify(matchups))
}

#endregion

#region Gamestate Functions
function StartNewGamestate()
{
	// Generate Teamslist
	teamList = UltManTeams()
	ds_list_replace(teamList, 0, playerClub)
	
	// Generate squad
	var squadList = ds_list_create()
	var squadJsonArray = []
	for (var i = 0; i < 19; ++i) {
		var player = new UltManPlayer()
		
		ds_list_add(squad, player)
		switch(i)
		{
			case 0:
				player.position = FootballPositions.GK
				player.preferredPosition = FootballPositions.GK
				ds_list_clear(player.playableColumns)
				ds_list_add(player.playableColumns, FormationColumns.Goalkeeper)
				ds_list_add(formationColumns[FormationColumns.Goalkeeper], player)
				break;
			case 1:
				player.position = FootballPositions.LB
				player.preferredPosition = FootballPositions.LB
				ds_list_clear(player.playableColumns)
				ds_list_add(player.playableColumns, FormationColumns.Defense)
				ds_list_add(formationColumns[FormationColumns.Defense], player)
				break;
			case 2:
			case 3:
				player.position = FootballPositions.CB
				player.preferredPosition = FootballPositions.CB
				ds_list_clear(player.playableColumns)
				ds_list_add(player.playableColumns, FormationColumns.Defense)
				ds_list_add(formationColumns[FormationColumns.Defense], player)
				break
			case 4:
				player.position = FootballPositions.RB
				player.preferredPosition = FootballPositions.RB
				ds_list_clear(player.playableColumns)
				ds_list_add(player.playableColumns, FormationColumns.Defense)
				ds_list_add(formationColumns[FormationColumns.Defense], player)
				break;
			case 5:
				player.position = FootballPositions.LM
				player.preferredPosition = FootballPositions.LM
				ds_list_clear(player.playableColumns)
				ds_list_add(player.playableColumns, FormationColumns.Midfield)
				ds_list_add(formationColumns[FormationColumns.Midfield], player)
				break;
			case 6:
			case 7:
				player.position = FootballPositions.CM
				player.preferredPosition = FootballPositions.CM
				ds_list_clear(player.playableColumns)
				ds_list_add(player.playableColumns, FormationColumns.Midfield)
				ds_list_add(formationColumns[FormationColumns.Midfield], player)
				break;
			case 8:
				player.position = FootballPositions.LM
				player.preferredPosition = FootballPositions.LM
				ds_list_clear(player.playableColumns)
				ds_list_add(player.playableColumns, FormationColumns.Midfield)
				ds_list_add(formationColumns[FormationColumns.Midfield], player)
				break;
			case 9:
			case 10:
				player.position = FootballPositions.ST
				player.preferredPosition = FootballPositions.ST
				ds_list_clear(player.playableColumns)
				ds_list_add(player.playableColumns, FormationColumns.Attackers)
				ds_list_add(formationColumns[FormationColumns.Attackers], player)
			break;
		}
	}
	SaveGamestate()
}

function LoadGamestate(Json)
{
	var gamestateMap = json_decode(Json)
	
	var lineupArray = ds_map_values_to_array(json_decode(gamestateMap[?"lineup"]))
	var squadArray = ds_map_values_to_array(json_decode(gamestateMap[?"squad"]))
	var leagueArray = ds_map_values_to_array(json_decode(gamestateMap[?"league"]))
	
	#region Squad

	var parsed_data = json_parse(gamestateMap[?"squad"]);
	var len = array_length(parsed_data);

	// Loop through each parsed JSON object
	for (var amount = 0; amount < len; amount++) {
    
	    // Create a struct for the player
	    var playerStruct = json_parse(parsed_data[amount]);
		var player = new UltManPlayer()

		// Loop through the fields and copy values dynamically
		var fields = variable_struct_get_names(playerStruct);
		for (var i = 0; i < array_length(fields); i++) {
		    var fieldName = fields[i];

			// Check if the field exists in the original struct to avoid errors
			if (variable_struct_exists(playerStruct, fieldName)) {
				struct_set(player, fieldName, struct_get(playerStruct, fieldName))
			}
		}
		
		// Add playable positions
		player.playableColumns = array_to_ds_list(json_parse(player.playableColumns))
		
	    ds_list_add(squad, player)
	}
	#endregion
	
	#region Lineup
	var lineup = json_parse(gamestateMap[?"lineup"]);
	var len = array_length(lineup);
	var column = 5
	for (var i = 0; i < 11; ++i) 
	{
	    ds_list_add(formationColumns[column], ds_list_find_value(squad, i))
		if (array_length(lineup[column]) = ds_list_size(formationColumns[column]))
		{
			scr_reverseDsList(formationColumns[column])
			if (column != 0){column--}
			while (array_length(lineup[column]) = 0 and column != 0)
			{
				column--
			}
		}
	}
	#endregion

	#region League
	var parsed_data = json_parse(gamestateMap[?"league"]);
	var len = array_length(parsed_data);

	// Loop through each parsed JSON object
	for (var amount = 0; amount < len; amount++) {
    
	    // Create a struct for the player
	    var leagueTeamStruct = json_parse(parsed_data[amount]);
		var leagueTeam = new UltManTeam()

		// Loop through the fields and copy values dynamically
		var fields = variable_struct_get_names(leagueTeamStruct);
		for (var i = 0; i < array_length(fields); i++) {
		    var fieldName = fields[i];

			// Check if the field exists in the original struct to avoid errors
			if (variable_struct_exists(leagueTeamStruct, fieldName)) {
				struct_set(leagueTeam, fieldName, struct_get(leagueTeamStruct, fieldName))
			}
		}
		
	    ds_list_add(teamList, leagueTeam)
	}
	#endregion
	
	#region Team
		obj_UltManManagerController.playerClub = json_parse(gamestateMap[?"team"]);
		obj_UltManManagerController.clubName = playerClub.clubName
	#endregion
}

function SaveGamestate()
{
	// Save league teams
	var leagueArray = []
	for (var i = 0; i < ds_list_size(teamList); ++i) {
		leagueArray[i] = json_stringify(ds_list_find_value(teamList, i))
	}
	
	// Encode squadColumn data structure
	var formationArray = []
	for (var column = 0; column < array_length(formationColumns); ++column) {
	    
		var tempArray = []
		for (var i = 0; i < ds_list_size(formationColumns[column]); ++i) {
			tempArray[i] = json_stringify(ds_list_find_value(formationColumns[column], i))
		}
		formationArray[column] = tempArray
	}

	// Encode squad list
	var squadJsonArray = []
	for (var i = 0; i < ds_list_size(squad); ++i) {
		
		var player = ds_list_find_value(squad, i)
		var tempPlayableColumn = player.playableColumns
		player.playableColumns = json_stringify(ds_list_to_array(player.playableColumns))
		squadJsonArray[i] = json_stringify(player)
		player.playableColumns = tempPlayableColumn
	}
	
	// Save gamestate
	var gamestateMap = ds_map_create()
	
	gamestateMap[?"squad"] = json_stringify(squadJsonArray, true)
	gamestateMap[?"lineup"] = json_stringify(formationArray, true)
	gamestateMap[?"league"] = json_stringify(leagueArray, true)
	gamestateMap[?"team"] = json_stringify(obj_UltManManagerController.playerClub, true)
	
	obj_firestore_controller.SaveGamestate("ultimateManager", json_encode(gamestateMap))
	ds_map_destroy(gamestateMap)
}
#endregion