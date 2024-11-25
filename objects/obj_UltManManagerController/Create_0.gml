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

// Language controller
LC = obj_languageController

// Variables
playerClub = new UltManTeam()
playerOpponentTeam = undefined

teamStats = [["Matches Played",spr_UltManFootball, obj_UltManManagerController.playerClub.matchesPlayed],
["Win Percentage",spr_UltManPercentage, obj_UltManManagerController.playerClub.winPercentage],
["Goals Scored", spr_UltManCheckmark, obj_UltManManagerController.playerClub.goalsScored],
["Goals Conceded",spr_UltManCancel, obj_UltManManagerController.playerClub.goalsConceded],
["Yellow Cards", spr_UltManWarning, obj_UltManManagerController.playerClub.yellowCards],
["Red Cards",spr_UltManRedCard, obj_UltManManagerController.playerClub.redCards]]
// 
clubName = playerClub.clubName
newClubName = playerClub.clubName

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
// Transfermarket Player Card Timer
transfermarketPlayerCardTimer = 0
// Change Club Name
changeClubNamePopup = false
// Warn user about club name length
clubNameLimit = undefined;

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

// Local Persistence control
lastScoreline = [0,0]
halftimeCompleted = false
halftimeTimerReset = true
seasonGameweeks = undefined
gameweekCounter = 0

// Generate team from server
obj_firestore_controller.RequestGamestate("ultimateManager")
newClubName = playerClub.clubName

packs = ds_list_create();
ds_list_add(packs, new UltManPack(UltManPackTier.Bronze));
ds_list_add(packs, new UltManPack(UltManPackTier.Silver));
ds_list_add(packs, new UltManPack(UltManPackTier.Gold));
ds_list_add(packs, new UltManPack(UltManPackTier.Ruby));
ds_list_add(packs, new UltManPack(UltManPackTier.Obsidian));
ds_list_add(packs, new UltManPack(UltManPackTier.Legendary)); 
  
#region Gamelogic functions

function SimulateLeague(playerGoals, opponentGoals)
{
	//GenerateMatchups()
	matchups = seasonGameweeks[gameweekCounter];
	
	// Generate results
	for (var i = 0; i < array_length(matchups); ++i) {
	    
		if (array_length(matchups[i]) != 0)
		{
			// Stop if matchup is the players match
			if (matchups[i][0] != playerClub.clubName and matchups[i][1] != playerClub.clubName)
			{
				var homeTeam = find_struct_in_list(teamList, "clubName", matchups[i][0])
				var awayTeam = find_struct_in_list(teamList, "clubName", matchups[i][1])
				
				// point system
				var MatchXG = [0,0]
		
				// Simulate results
				var possessionRatio = (homeTeam.ballPossesion + homeTeam.midfielderQuality*2)/(awayTeam.ballPossesion + homeTeam.midfielderQuality*2)
		
				if (possessionRatio > 1)
				{
					var dominantTeamIndex = 0
					var dominantTeam = homeTeam
					var submissiveTeam = awayTeam
				}
				else
				{
					var dominantTeamIndex = 1
					var dominantTeam = awayTeam
					var submissiveTeam = homeTeam
				}
		
				// Dominant team
				var chancesCreated = 8 + (possessionRatio-1)*10
				var chanceQuality = homeTeam.attackerQuality/(awayTeam.defenderQuality*2 + awayTeam.goalKeeperQuality)/3
				MatchXG[dominantTeamIndex] = chancesCreated*chanceQuality
		
				// Submissive team
				var chancesCreated = 3 + dominantTeam.counterAttacks
				var chanceQuality = homeTeam.attackerQuality/(awayTeam.defenderQuality*2 + awayTeam.goalKeeperQuality)/3
				MatchXG[!dominantTeamIndex] = chancesCreated*chanceQuality
		
				if (abs(MatchXG[dominantTeamIndex] - MatchXG[!dominantTeamIndex]) < 9)
				{
					homeTeam.matchesDrawn++
					awayTeam.matchesDrawn++
					homeTeam.matchesPlayed++
					awayTeam.matchesPlayed++
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
		}
	}
	
	// Player Results
	if (playerGoals > opponentGoals)
	{
		// Won
		obj_UltManManagerController.playerClub.matchesWon++
		playerOpponentTeam.matchesLost++	
	}
	else if (playerGoals < opponentGoals)
	{
		// Lost
		obj_UltManManagerController.playerClub.matchesLost++
		playerOpponentTeam.matchesWon++
	}
	else
	{
		// Draw
		playerOpponentTeam.matchesDrawn++
		obj_UltManManagerController.playerClub.matchesDrawn++
	}
	obj_firestore_controller.UpdateBalance()
	obj_UltManManagerController.playerClub.matchesPlayed++
	playerOpponentTeam.matchesPlayed++
	obj_UltManManagerController.playerClub.winPercentage = string(round((obj_UltManManagerController.playerClub.matchesWon / obj_UltManManagerController.playerClub.matchesPlayed)*100))+"%"
	
	// Update points
	for (var i = 0; i < ds_list_size(teamList); ++i) {
	    var team = ds_list_find_value(teamList, i)
		
		team.totalPoints = team.matchesWon*3 + team.matchesDrawn
	}

	// Next gameweek
	gameweekCounter++
	
	// Reset League
	if (gameweekCounter = 38)
	{
		gameweekCounter = 0
		
		for (var i = 0; i < ds_list_size(teamList); ++i) {
		    team = ds_list_find_value(teamList, i)
			 
			with(team)
			{
				matchesWon = 0
				matchesDrawn = 0
				matchesLost = 0
				matchesPlayed = 0
				winPercentage = 0
			    totalPoints = 0
				goalsScored = 0
				goalsConceded = 0
				yellowCards = 0
				redCards = 0
			}
		}
	}
	
	matchups = seasonGameweeks[gameweekCounter]

	// Find opponent
	var GameWeek = seasonGameweeks[gameweekCounter]
	for (var i = 0; i < array_length(GameWeek); ++i) {
	    // Find player
		if (GameWeek[i][0] = playerClub.clubName)
		{
			playerOpponentTeam = find_struct_in_list(teamList, "clubName", GameWeek[i][1])  
		}
		else if (GameWeek[i][1] = playerClub.clubName)
		{
			playerOpponentTeam = find_struct_in_list(teamList, "clubName", GameWeek[i][0])
		}
	}
	
	scr_sort_struct_list(teamList, "totalPoints", false)
	SaveGamestate()
	//ds_list_destroy(clubsAvailable)
}

function GenerateMatchups()
{
	// Script to generate a 38-gameweek schedule for 20 teams with proper handling and structure
	var num_teams = 20;
	var total_gameweeks = 38;
	var half_gameweeks = total_gameweeks / 2;
	var matches_per_week = num_teams / 2; // 10 matches per week

	// Initialize the main schedule array to hold the entire season's matchups
	var season_schedule = [];

	// Create lists for initial setup
	var teamsAvailable = ds_list_create();
	for (var i = 0; i < num_teams; i++) {
	    ds_list_add(teamsAvailable, ds_list_find_value(teamList, i)); // Assume each team has a unique ID from 0 to 19
	}

	// Generate the first half of the season (19 gameweeks)
	for (var week = 0; week < half_gameweeks; week++) {
	    var clubsAvailable = ds_list_create();
	    ds_list_copy(clubsAvailable, teamsAvailable);
    
	    var gameweek = []; // Array to hold 10 matchups for this gameweek

	    // Generate 10 matchups for this gameweek
	    for (var match = 0; match < matches_per_week; match++) {
	        // Home Club
	        var homeClubId = ds_list_find_value(clubsAvailable, irandom_range(0, ds_list_size(clubsAvailable) - 1));
	        ds_list_delete(clubsAvailable, ds_list_find_index(clubsAvailable, homeClubId));
        
	        // Away Club
	        var awayClubId = ds_list_find_value(clubsAvailable, irandom_range(0, ds_list_size(clubsAvailable) - 1));
	        ds_list_delete(clubsAvailable, ds_list_find_index(clubsAvailable, awayClubId));

	        // Store this matchup as an array of the two clubs
	        var matchup = [homeClubId.clubName, awayClubId.clubName];
	        array_push(gameweek, matchup);
	    }
    
	    // Add this completed gameweek to the season schedule
	    array_push(season_schedule, gameweek);
	    ds_list_destroy(clubsAvailable); // Clean up the list to free memory
	}

	// Generate the second half of the season by reversing home/away for each matchup
	for (var week = 0; week < half_gameweeks; week++) {
	    var first_half_gameweek = season_schedule[week];
	    var gameweek = []; // New gameweek for reversed matchups

	    // Reverse home and away for each matchup
	    for (var i = 0; i < array_length(first_half_gameweek); i++) {
	        var matchup = first_half_gameweek[i];
	        var reversed_matchup = [matchup[1], matchup[0]]; // Reverse the order
	        array_push(gameweek, reversed_matchup);
	    }

	    // Add this completed gameweek to the season schedule
	    array_push(season_schedule, gameweek);
	}

	// Clean up any lists used
	ds_list_destroy(teamsAvailable);
	
	// Find opponent
	var firstWeek = season_schedule[0]
	for (var i = 0; i < array_length(firstWeek); ++i) {
	    // Find player
		if (firstWeek[i][0] = playerClub.clubName)
		{
			playerOpponentTeam = find_struct_in_list(teamList, "clubName", firstWeek[i][1])
		}
		else if (firstWeek[i][1] = playerClub.clubName)
		{
			playerOpponentTeam = find_struct_in_list(teamList, "clubName", firstWeek[i][0])
		}
	}

	// 'season_schedule' is now a 3D array holding 38 gameweeks, each with 10 matchups
	return season_schedule;
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
	seasonGameweeks = GenerateMatchups()
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
		obj_UltManManagerController.newClubName = playerClub.clubName
		obj_UltManManagerController.playerClub = find_struct_in_list(teamList, "clubName", clubName)
	#endregion
	
	seasonGameweeks = json_parse(gamestateMap[?"fixtures"]);
	gameweekCounter = json_parse(gamestateMap[?"gameweek"])
	
	// Find opponent
	var GameWeek = seasonGameweeks[gameweekCounter]
	for (var i = 0; i < array_length(GameWeek); ++i) {
	    // Find player
		if (GameWeek[i][0] = playerClub.clubName)
		{
			playerOpponentTeam = find_struct_in_list(teamList, "clubName", GameWeek[i][1])  
		}
		else if (GameWeek[i][1] = playerClub.clubName)
		{
			playerOpponentTeam = find_struct_in_list(teamList, "clubName", GameWeek[i][0])
		}
	}
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
	gamestateMap[?"fixtures"] = json_stringify(seasonGameweeks, true)
	gamestateMap[?"gameweek"] = json_stringify(gameweekCounter)
	
	obj_firestore_controller.SaveGamestate("ultimateManager", json_encode(gamestateMap))
	ds_map_destroy(gamestateMap)
}
#endregion