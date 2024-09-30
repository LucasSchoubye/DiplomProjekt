// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManRandomPosition(player){

	switch(round(random_range(1,14)))
	{
		case 1:
			player.preferredPosition = FootballPositions.GK
			ds_list_add(player.playableColumns, FormationColumns.Goalkeeper)
		break;
		
		// Defenders
		case 2:
			player.preferredPosition = FootballPositions.CB
			ds_list_add(player.playableColumns, FormationColumns.Defense)
			if (random_range(1,100) > 80){ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)}
		break;
		case 3:
			player.preferredPosition = FootballPositions.LB
			ds_list_add(player.playableColumns, FormationColumns.Defense)
			if (random_range(1,100) > 85){ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)}
		break;
		case 4:
			player.preferredPosition = FootballPositions.RB
			ds_list_add(player.playableColumns, FormationColumns.Defense)
			if (random_range(1,100) > 85){ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)}
		break;
		case 5:
			player.preferredPosition = FootballPositions.RWB
			ds_list_add(player.playableColumns, FormationColumns.Defense)
			if (random_range(1,100) > 90){ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)}
			if (random_range(1,100) > 70){ds_list_add(player.playableColumns, FormationColumns.Attackers)}
		break;
		case 6:
			player.preferredPosition = FootballPositions.LWB
			ds_list_add(player.playableColumns, FormationColumns.Defense)
			if (random_range(1,100) > 90){ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)}
			if (random_range(1,100) > 70){ds_list_add(player.playableColumns, FormationColumns.Attackers)}
		break;
		
		// Midfield
		case 7:
			player.preferredPosition = FootballPositions.CM
			ds_list_add(player.playableColumns, FormationColumns.Midfield)
			if (random_range(1,100) > 75){ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)}
			if (random_range(1,100) > 60){ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)}
		break;
		case 8:
			player.preferredPosition = FootballPositions.CDM
			ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)
			if (random_range(1,100) > 50){ds_list_add(player.playableColumns, FormationColumns.Midfield)}
			if (random_range(1,100) > 50){ds_list_add(player.playableColumns, FormationColumns.Defense)}
		break;
		case 9:
			player.preferredPosition = FootballPositions.CAM
			ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)
			if (random_range(1,100) > 70){ds_list_add(player.playableColumns, FormationColumns.Attackers)}
			if (random_range(1,100) > 50){ds_list_add(player.playableColumns, FormationColumns.Midfield)}
			if (random_range(1,100) > 90){ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)}
		break;
		case 10:
			player.preferredPosition = FootballPositions.RM
			ds_list_add(player.playableColumns, FormationColumns.Midfield)
			if (random_range(1,100) > 75){ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)}
			if (random_range(1,100) > 60){ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)}
		break;
		case 11:
			player.preferredPosition = FootballPositions.LM
			ds_list_add(player.playableColumns, FormationColumns.Midfield)
			if (random_range(1,100) > 75){ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)}
			if (random_range(1,100) > 60){ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)}

		break;
		
		// Attackers
		case 12:
			player.preferredPosition = FootballPositions.ST
			ds_list_add(player.playableColumns, FormationColumns.Attackers)
			if (random_range(1,100) > 75){ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)}
		break;
		case 13:
			player.preferredPosition = FootballPositions.RW
			ds_list_add(player.playableColumns, FormationColumns.Attackers)
			if (random_range(1,100) > 65){ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)}
		break;
		case 14:
			player.preferredPosition = FootballPositions.LW
			ds_list_add(player.playableColumns, FormationColumns.Attackers)
			if (random_range(1,100) > 65){ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)}
		break;
	}

}