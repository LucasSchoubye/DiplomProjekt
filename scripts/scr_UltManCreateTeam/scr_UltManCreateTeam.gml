// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManCreateEnemyTeam(tier){


	switch(irandom(0))
	{
		#region 4-4-2
		case 0:
			// Goalie
			var player = instance_create_depth(room_width - room_width*0.1,room_height*0.5,0,obj_UltManOpponent)
			player.position = FootballPositions.GK
			
			// Defehders
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.4,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.6,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.2,0,obj_UltManOpponent)
			player.position = FootballPositions.LB
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.8,0,obj_UltManOpponent)
			player.position = FootballPositions.RB
			scr_UltManSetPlayerStatsToTier(tier, player)
			
			// Midfielders
			var player = instance_create_depth(room_width - room_width*0.3,room_height*0.4,0,obj_UltManOpponent)
			player.position = FootballPositions.CM
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width - room_width*0.3,room_height*0.6,0,obj_UltManOpponent)
			player.position = FootballPositions.CM
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width - room_width*0.3,room_height*0.2,0,obj_UltManOpponent)
			player.position = FootballPositions.LM
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width - room_width*0.3,room_height*0.8,0,obj_UltManOpponent)
			player.position = FootballPositions.RM
			scr_UltManSetPlayerStatsToTier(tier, player)
			// Strikers
			var player = instance_create_depth(room_width - room_width*0.4,room_height*0.4,0,obj_UltManOpponent)
			player.position = FootballPositions.ST
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width - room_width*0.4,room_height*0.6,0,obj_UltManOpponent)
			player.position = FootballPositions.ST
			scr_UltManSetPlayerStatsToTier(tier, player)
		break;
		#endregion 4-4-2
		
		case TeamFormations.DefenseTest:
			// Defehders
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.4,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.6,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.2,0,obj_UltManOpponent)
			player.position = FootballPositions.LB
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.8,0,obj_UltManOpponent)
			player.position = FootballPositions.RB
		break;
	}

}