/// @description Setup Menu and variables
enum ultManMenus{
	Home,
	Tactics,
	Fixtures,
	Transfermarket,
	Quit
}

UltManTeams()

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
clubName = "Arsenal FC"
menuOptions = ds_list_create()
selectedMenuOption = 0
currentMenu = ultManMenus.Home
// This variable is used in the transfermarket to determine if a user wants to sell a player
showSellPopup = false; 
// This variable is used in the transfermarket if the user is trying to sell a player in the active team
showCannotSellPopup = false
// This variable is used in the transfermarket if the user is trying to buy a pack but they meet insufficient requirements
showPopupCannotBuyPack = false

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

// Test Players
scr_UltManTestTeamArsenal()

for (var i = 0; i < 4; ++i) {
    ds_list_add(squad, new UltManPlayer())
}

packs = ds_list_create();
ds_list_add(packs, new UltManPack(UltManPackTier.Bronze));
ds_list_add(packs, new UltManPack(UltManPackTier.Silver));
ds_list_add(packs, new UltManPack(UltManPackTier.Gold));
ds_list_add(packs, new UltManPack(UltManPackTier.Ruby));
ds_list_add(packs, new UltManPack(UltManPackTier.Obsidian));
ds_list_add(packs, new UltManPack(UltManPackTier.Legendary)); 
  
// Functions
function StartNewGamestate()
{
	// Generate Teamslist
	teamList = UltManTeams()
	
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
		var leagueTeam = new UltManPlayer()

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
	
	obj_firestore_controller.SaveGamestate("ultimateManager", json_encode(gamestateMap))
	ds_map_destroy(gamestateMap)
}