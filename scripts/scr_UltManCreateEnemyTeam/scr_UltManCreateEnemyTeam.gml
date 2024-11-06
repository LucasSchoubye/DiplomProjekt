// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManCreateTeam(tier){

enum TeamFormations
{
	FourFourTwo,
	FourThreeThree,
	DefenseTest,
}


	switch(TeamFormations.FourFourTwo)
	{
		case TeamFormations.FourFourTwo:
			// Goalie
			var player = instance_create_depth(room_width*0.1,room_height*0.5,0,obj_UltManPlayer)
			player.position = FootballPositions.GK
			scr_UltManSetPlayerStatsToTier(tier, player)
			
			// Defehders
			var player = instance_create_depth(room_width*0.2,room_height*0.4,0,obj_UltManPlayer)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width*0.2,room_height*0.6,0,obj_UltManPlayer)
			player.position = FootballPositions.CB
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width*0.2,room_height*0.2,0,obj_UltManPlayer)
			player.position = FootballPositions.LB
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width*0.2,room_height*0.8,0,obj_UltManPlayer)
			player.position = FootballPositions.RB
			scr_UltManSetPlayerStatsToTier(tier, player)
			
			// Midfielders
			var player = instance_create_depth(room_width*0.3,room_height*0.4,0,obj_UltManPlayer)
			player.position = FootballPositions.CM
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width*0.3,room_height*0.6,0,obj_UltManPlayer)
			player.position = FootballPositions.CM
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width*0.3,room_height*0.2,0,obj_UltManPlayer)
			player.position = FootballPositions.LM
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width*0.3,room_height*0.8,0,obj_UltManPlayer)
			player.position = FootballPositions.RM
			scr_UltManSetPlayerStatsToTier(tier, player)
			
			// Strikers
			var player = instance_create_depth(room_width*0.4,room_height*0.4,0,obj_UltManPlayer)
			player.position = FootballPositions.ST
			scr_UltManSetPlayerStatsToTier(tier, player)
			var player = instance_create_depth(room_width*0.4,room_height*0.6,0,obj_UltManPlayer)
			player.position = FootballPositions.ST
			scr_UltManSetPlayerStatsToTier(tier, player)
		break;
		
		case TeamFormations.DefenseTest:
					// Defehders
			var player = instance_create_depth(room_width*0.2,room_height*0.4,0,obj_UltManPlayer)
			player.position = FootballPositions.CB
			var player = instance_create_depth(room_width*0.2,room_height*0.6,0,obj_UltManPlayer)
			player.position = FootballPositions.CB
			var player = instance_create_depth(room_width*0.2,room_height*0.2,0,obj_UltManPlayer)
			player.position = FootballPositions.LB
			var player = instance_create_depth(room_width*0.2,room_height*0.8,0,obj_UltManPlayer)
			player.position = FootballPositions.RB
		break;
	}

}


function scr_UltManSetPlayerStatsToTier(tier, player)
{
	var structPlayer = new UltManPlayer(tier)
	scr_UltManGeneratePlayerStats(player, player.position, tier);
	
	player.name = structPlayer.name
	player.playerStruct = structPlayer
			
	// Stats
	player.defence = structPlayer.defence
	player.dribbling = structPlayer.dribbling
	player.topSpd = structPlayer.topSpd
	player.strength = structPlayer.strength
	player.topPassSpd = structPlayer.topPassSpd
	player.topShootSpd = structPlayer.topShootSpd
	player.shooting = structPlayer.shooting
	player.passing = structPlayer.passing
}