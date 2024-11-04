// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManCreateEnemyTeam(tier){


	var opponentClub = obj_UltManManagerController.playerOpponentTeam
	
	// Overall tier
	if (opponentClub.clubRating > 80)
		tier++
	if (opponentClub.clubRating > 90)
		tier++
	
	if (tier > UltManPackTier.Legendary)
		tier = UltManPackTier.Legendary
		
	var attackTier = tier
	var midfielderTier = tier
	var defenseTier = tier
	
	if (opponentClub.attackerQuality > 85)
		attackTier++
		
	if (opponentClub.midfielderQuality > 85)
		midfielderTier++
	
	if (opponentClub.defenderQuality > 85)
		defenseTier++

	show_message("Overall Tier: " + string(tier) + 
				", Attacker Tier: "+ string(attackTier) + 
				", Midfielder Tier: " + string(midfielderTier) + 
				", Defender Tier: " + string(defenseTier)) 

	switch(irandom(2))
	{
		#region 4-4-2
		case 0:
			// Goalie
			var player = instance_create_depth(room_width - room_width*0.1,room_height*0.5,0,obj_UltManOpponent)
			player.position = FootballPositions.GK
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			
			// Defenders
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.4,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.6,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.2,0,obj_UltManOpponent)
			player.position = FootballPositions.LB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.8,0,obj_UltManOpponent)
			player.position = FootballPositions.RB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			
			// Midfielders
			var player = instance_create_depth(room_width - room_width*0.3,room_height*0.4,0,obj_UltManOpponent)
			player.position = FootballPositions.CM
			scr_UltManSetPlayerStatsToTier(midfielderTier, player)
			var player = instance_create_depth(room_width - room_width*0.3,room_height*0.6,0,obj_UltManOpponent)
			player.position = FootballPositions.CM
			scr_UltManSetPlayerStatsToTier(midfielderTier, player)
			var player = instance_create_depth(room_width - room_width*0.3,room_height*0.2,0,obj_UltManOpponent)
			player.position = FootballPositions.LM
			scr_UltManSetPlayerStatsToTier(midfielderTier, player)
			var player = instance_create_depth(room_width - room_width*0.3,room_height*0.8,0,obj_UltManOpponent)
			player.position = FootballPositions.RM
			scr_UltManSetPlayerStatsToTier(midfielderTier, player)
			
			// Strikers
			var player = instance_create_depth(room_width - room_width*0.4,room_height*0.4,0,obj_UltManOpponent)
			player.position = FootballPositions.ST
			scr_UltManSetPlayerStatsToTier(attackTier, player)
			var player = instance_create_depth(room_width - room_width*0.4,room_height*0.6,0,obj_UltManOpponent)
			player.position = FootballPositions.ST
			scr_UltManSetPlayerStatsToTier(attackTier, player)
		break;
		#endregion 4-4-2
		
		#region 4-3-3
		case 1:
			// Goalie
			var player = instance_create_depth(room_width - room_width*0.1,room_height*0.5,0,obj_UltManOpponent)
			player.position = FootballPositions.GK
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			
			// Defenders
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.4,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.6,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.2,0,obj_UltManOpponent)
			player.position = FootballPositions.LB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.8,0,obj_UltManOpponent)
			player.position = FootballPositions.RB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			
			// Midfielders
			var player = instance_create_depth(room_width - room_width*0.3, room_height*0.25, 0,obj_UltManOpponent)
			player.position = FootballPositions.CM
			scr_UltManSetPlayerStatsToTier(midfielderTier, player)
			var player = instance_create_depth(room_width - room_width*0.3, room_height*0.5, 0,obj_UltManOpponent)
			player.position = FootballPositions.CDM
			scr_UltManSetPlayerStatsToTier(midfielderTier, player)
			var player = instance_create_depth(room_width - room_width*0.3, room_height*0.75, 0,obj_UltManOpponent)
			player.position = FootballPositions.CM
			scr_UltManSetPlayerStatsToTier(midfielderTier, player)
			
			// Strikers
			var player = instance_create_depth(room_width - room_width*0.4,room_height*0.2,0,obj_UltManOpponent)
			player.position = FootballPositions.LW
			scr_UltManSetPlayerStatsToTier(attackTier, player)
			var player = instance_create_depth(room_width - room_width*0.4,room_height*0.5,0,obj_UltManOpponent)
			player.position = FootballPositions.ST
			scr_UltManSetPlayerStatsToTier(attackTier, player)
			var player = instance_create_depth(room_width - room_width*0.4,room_height*0.8,0,obj_UltManOpponent)
			player.position = FootballPositions.RW
			scr_UltManSetPlayerStatsToTier(attackTier, player)
		break;
		#endregion 4-3-3
		
		#region 3-5-2
		case 2:
			// Goalie
			var player = instance_create_depth(room_width - room_width*0.1,room_height*0.5,0,obj_UltManOpponent)
			player.position = FootballPositions.GK
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			
			// Defenders
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.25,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.5,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.75,0,obj_UltManOpponent)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.1,0,obj_UltManOpponent)
			player.position = FootballPositions.LWB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			var player = instance_create_depth(room_width - room_width*0.2,room_height*0.9,0,obj_UltManOpponent)
			player.position = FootballPositions.RWB
			scr_UltManSetPlayerStatsToTier(defenseTier, player)
			
			// Midfielders
			var player = instance_create_depth(room_width - room_width*0.3, room_height*0.25, 0,obj_UltManOpponent)
			player.position = FootballPositions.CM
			scr_UltManSetPlayerStatsToTier(midfielderTier, player)
			var player = instance_create_depth(room_width - room_width*0.3, room_height*0.5, 0,obj_UltManOpponent)
			player.position = FootballPositions.CDM
			scr_UltManSetPlayerStatsToTier(midfielderTier, player)
			var player = instance_create_depth(room_width - room_width*0.3, room_height*0.75, 0,obj_UltManOpponent)
			player.position = FootballPositions.CM
			scr_UltManSetPlayerStatsToTier(midfielderTier, player)
			
			// Strikers
			var player = instance_create_depth(room_width - room_width*0.4,room_height*0.4,0,obj_UltManOpponent)
			player.position = FootballPositions.ST
			scr_UltManSetPlayerStatsToTier(attackTier, player)
			var player = instance_create_depth(room_width - room_width*0.4,room_height*0.6,0,obj_UltManOpponent)
			player.position = FootballPositions.ST
			scr_UltManSetPlayerStatsToTier(attackTier, player)
		break;
		#endregion 3-5-2

	}

}