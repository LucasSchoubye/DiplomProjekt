/// @description Setup Menu and variables
enum ultManMenus{
	Home,
	Tactics,
	Fixtures,
	Transfermarket
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

UltManTeams()

// Variables
clubName = "Arsenal FC"
menuOptions = ds_list_create()
selectedMenuOption = 0
currentMenu = ultManMenus.Home

// Populate menu options
ds_list_add(menuOptions, "Home")
ds_list_add(menuOptions, "Tactics")
ds_list_add(menuOptions, "Fixtures")
ds_list_add(menuOptions, "Transfermarket")

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

// Functions
function StartNewGamestate()
{
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
		
		squadJsonArray[i] = json_stringify(player)
	}
	
	// Encode squadColumn data structure
	var squadArray = []
	for (var column = 0; column < array_length(formationColumns); ++column) {
	    
		var tempArray = []
		for (var i = 0; i < ds_list_size(formationColumns[column]); ++i) {
			tempArray[i] = json_stringify(ds_list_find_value(formationColumns[column], i))
		}
		squadArray[column] = tempArray
	}

	
	// Save gamestate
	var gamestateMap = ds_map_create()
	
	gamestateMap[?"squad"] = json_stringify(squadJsonArray, true)
	gamestateMap[?"lineup"] = json_stringify(squadArray, true)
	
	obj_firestore_controller.SaveGamestate("ultimateManager", json_encode(gamestateMap))
	ds_map_destroy(gamestateMap)
}

function LoadGamestate(Json)
{
	var gamestateMap = json_decode(Json)
	
	var lineupArray = ds_map_values_to_array(json_decode(gamestateMap[?"lineup"]))
	var squadArray = ds_map_values_to_array(json_decode(gamestateMap[?"squad"]))

	
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
		
	    ds_list_add(squad, player)
		//show_message("Ingame Player: "+json_stringify(player))
		//show_message("server Player: "+json_stringify(playerStruct))
	}
	#endregion
	
	#region Lineup
	var lineup = json_parse(gamestateMap[?"lineup"]);
	var len = array_length(lineup);
	
	show_message(len)
	
	var column = 5
	for (var i = 0; i < 11; ++i) 
	{
	    ds_list_add(formationColumns[column], ds_list_find_value(squad, i))
		if (array_length(lineup[column]) = ds_list_size(formationColumns[column]) && column != 0)
		{
			column--
			while (array_length(lineup[column]) = 0 and column != 0)
			{
				column--
			}
			show_message("Next Column size: "+string(array_length(lineup[column])))
		}
	}
	
	//ds_list_add(formationColumns[5], ds_list_find_value(squad, i))
	
	show_message(parsed_data)
	#endregion
}